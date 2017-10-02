# frozen_string_literal: true
class Trial < ApplicationRecord
  # t.string   "title",        null: false
  # t.datetime "created_at",   null: false
  # t.datetime "updated_at",   null: false
  # t.integer  "committee_id", null: false
  # t.index ["committee_id"], name: "index_trials_on_committee_id", using: :btree

  # validations
  validates :title, presence: true, uniqueness: true
  validates :committee, presence: true
  STATUSES = %w(pending accepted rejected).freeze
  validates :status, inclusion: { within: STATUSES, allow_nil: true }

  # relations
  belongs_to :committee

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
end
