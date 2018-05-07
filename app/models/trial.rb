# frozen_string_literal: true
class Trial < ApplicationRecord # rubocop:disable Metrics/ClassLength
  # t.string   "title",                                        null: false
  # t.datetime "created_at",                                   null: false
  # t.datetime "updated_at",                                   null: false
  # t.integer  "committee_id",                                 null: false
  # t.date     "deadline"
  # t.string   "status",                   default: "pending", null: false
  # t.string   "email"
  # t.string   "phone_number"
  # t.string   "supervisor"
  # t.integer  "environment_id",                               null: false
  # t.string   "stateman_trial_id"
  # t.string   "private_key_digest"
  # t.string   "formsub_case_id"
  # t.string   "formsub_case_keyword"
  # t.integer  "rank_id",                                      null: false
  # t.integer  "stateman_state_id_cached"
  # t.string   "drive_folder"
  # t.boolean  "pending_changes",          default: false,     null: false
  # t.boolean  "formal_conditions",        default: false,     null: false
  # t.string   "supervisor_phone_number"
  # t.string   "supervisor_email"
  # t.string   "troop"
  # t.index ["committee_id"], name: "index_trials_on_committee_id", using: :btree
  # t.index ["private_key_digest"], name: "index_trials_on_private_key_digest",
  # unique: true, using: :btree
  # t.index ["rank_id"], name: "index_trials_on_rank_id", using: :btree

  # validations
  validates :title, presence: true, uniqueness: { scope: :committee }
  validates :committee, :deadline, presence: true
  validate :deadline_in_future, if: :deadline, on: :create
  STATUSES = %w(created pending accepted rejected).freeze
  validates :status, inclusion: { within: STATUSES, allow_nil: true }
  validates :email, :supervisor_email, presence: true, format: /@/
  validates :phone_number, :supervisor_phone_number, numericality: { only_integer: true },
                                                     length: { in: 9..13 }
  validates :supervisor, :environment, :rank, :troop, presence: true
  validates :private_key_digest, uniqueness: true, allow_blank: true
  validates :private_key, presence: true, on: :create, unless: :private_key_digest?
  validates :formal_conditions, acceptance: true, if: proc { committee&.formal_conditions.present? }

  def deadline_in_future
    errors.add(:deadline, I18n.t(:deadline_in_future)) if deadline < 1.month.from_now
  end

  # relations
  belongs_to :committee
  belongs_to :rank
  belongs_to :environment
  has_many   :tasks

  # callbacks
  after_save       :create_stateman_trial, :create_formsub_case
  before_destroy   :destroy_stateman_trial, :destroy_formsub_case
  after_create     :send_notification
  after_create     :create_drive_folder

  # scopes
  STATUSES.each do |status|
    scope status, -> { where(status: status) }
  end

  # scoped for pending trials (combine status and dealine)
  scope :ongoing, -> { pending.where('deadline > ?', Time.zone.now) }
  scope :overdue_soon, -> { ongoing.where('deadline < ?', Time.zone.now + 1.month) }
  scope :overdue, -> { pending.where('deadline <= ?', Time.zone.now) }

  # rest instance methods
  STATUSES.each do |loop_status|
    define_method("#{loop_status}?") { status == loop_status }
  end

  attr_accessor :referer, :private_key
  has_paper_trail unless: :created?, ignore: %w(stateman_state_id_cached drive_folder
                                                pending_changes),
                  skip: %w(pending_changes_set! pending_changes_reset!)
  acts_as_commentable :public, :private
  acts_as_commentable

  def update_safe(attributes)
    return update(attributes) if created?
    pending_changes_set!
    update(attributes)
  end

  def can_become_pending?
    created? && tasks.present? && committee.min_trial_tasks_count < tasks.count
  end

  def private_key=(value)
    return if value.blank?
    @private_key = "#{value}-#{SecureRandom.hex[0..2]}"
    self.private_key_digest = Digest::MD5.hexdigest(@private_key)
  end

  def stateman_trial
    return if stateman_trial_id.nil?
    @stateman_trial ||= find_stateman_trial
  end

  # rubocop:disable Style/AccessorMethodName
  def set_state_id(state_id)
    stateman_trial.update_attributes(item: { state_id: state_id },
                                     organization_id: committee.stateman.organization_id)
  end
  # rubocop:enable Style/AccessorMethodName

  def formsub_case
    create_formsub_case if formsub_case_id.nil?
    FormsubCase.find(formsub_case_id)
  end

  def committee
    @committee ||= super
  end

  def deadline_overdue
    # this method is responsible for auto changing state to overdue if deadline is passed
    # currently it is run from controller on show action
    # best way would be probably to use cron for this
    return unless deadline < Time.zone.now && stateman_state_id_cached != committee.overdue_state_id
    return unless stateman_trial.reachable_states.map(&:id).include? committee.overdue_state_id
    set_state_id(committee.overdue_state_id)
  end

  def drive_files
    create_drive_folder if drive_folder.blank?
    committee.drive.authorized.find_in_folder(drive_folder).files
  end

  def pending_changes_set!
    update(pending_changes: true)
  end

  def pending_changes_reset!
    update(pending_changes: false)
  end

  private

  def create_stateman_trial
    return unless stateman_trial_id.nil?
    stateman_trial = StatemanTrial.new(name: title)
    stateman_trial.prefix_options = { organization_id: committee.stateman.organization_id }

    update(stateman_trial_id: stateman_trial.id) if stateman_trial.save
  end

  def destroy_stateman_trial
    stateman_trial.destroy
  end

  def find_stateman_trial
    stateman_trial = StatemanTrial.find(stateman_trial_id, params: {
                                          organization_id: committee.stateman.organization_id
                                        })
    return stateman_trial if stateman_state_id_cached == stateman_trial.state.id
    update(stateman_state_id_cached: stateman_trial.state.id)
    stateman_trial
  end

  def create_formsub_case
    return unless committee.formsub_committee_id? && private_key_digest? && formsub_case_id.nil?
    formsub_case = FormsubCase.create(title: title, keyword: "#{id}-#{private_key_digest[0..2]}")

    return unless formsub_case.save
    update(formsub_case_id: formsub_case.id, formsub_case_keyword: formsub_case.keyword)
  end

  def destroy_formsub_case
    formsub_case.destroy if formsub_case_id?
  end

  def create_drive_folder
    folder = committee.drive.authorized.create_folder(title)
    update(drive_folder: folder.id)
  end

  def send_notification
    TrialNotificationMailer.created(self, @private_key).deliver
  end
end
