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
  # t.index ["committee_id"], name: "index_trials_on_committee_id", using: :btree

  # validations
  validates :title, presence: true, uniqueness: { scope: :committee }
  validates :committee, :deadline, presence: true
  STATUSES = %w(pending accepted rejected).freeze
  validates :status, inclusion: { within: STATUSES, allow_nil: true }
  validates :email, presence: true, format: /@/
  validates :phone_number, numericality: { only_integer: true }, length: { in: 9..13 }
  validates :supervisor, :environment, presence: true

  # relations
  belongs_to :committee

  # callbacks
  after_save :create_stateman_trial
  before_destroy :destroy_stateman_trial

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

  attr_accessor :referer

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
end
