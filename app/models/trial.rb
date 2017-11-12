# frozen_string_literal: true
class Trial < ApplicationRecord
  # t.string   "title",                                 null: false
  # t.datetime "created_at",                            null: false
  # t.datetime "updated_at",                            null: false
  # t.integer  "committee_id",                          null: false
  # t.date     "deadline"
  # t.string   "status",            default: "pending", null: false
  # t.string   "email"
  # t.string   "phone_number"
  # t.string   "supervisor"
  # t.string   "environment"
  # t.string   "stateman_trial_id"
  # t.string   "private_key_digest"
  # t.index ["committee_id"], name: "index_trials_on_committee_id", using: :btree
  # t.index ["private_key_digest"], name: "index_trials_on_private_key_digest",
  # unique: true, using: :btree

  # validations
  validates :title, presence: true, uniqueness: { scope: :committee }
  validates :committee, :deadline, presence: true
  STATUSES = %w(pending accepted rejected).freeze
  validates :status, inclusion: { within: STATUSES, allow_nil: true }
  validates :email, presence: true, format: /@/
  validates :phone_number, numericality: { only_integer: true }, length: { in: 9..13 }
  validates :supervisor, :environment, presence: true
  validates :private_key_digest, uniqueness: true, allow_blank: true
  validates :private_key, presence: true, on: :create, unless: :private_key_digest?

  # relations
  belongs_to :committee

  # callbacks
  after_save     :create_stateman_trial
  before_destroy :destroy_stateman_trial
  after_create   :send_notification

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

  def private_key=(value)
    return if value.blank?
    @private_key = "#{value}-#{SecureRandom.hex[0..2]}"
    self.private_key_digest = Digest::MD5.hexdigest(@private_key)
  end

  def stateman_trial
    StatemanTrial.find(stateman_trial_id, params: {
                         organization_id: committee.stateman.organization_id
                       })
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

  def send_notification
    TrialNotificationMailer.created(self, @private_key).deliver
  end
end
