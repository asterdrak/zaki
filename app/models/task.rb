# frozen_string_literal: true
class Task < ApplicationRecord
  # t.integer  "number",     null: false
  # t.integer  "trial_id",   null: false
  # t.text     "content",    null: false
  # t.datetime "deadline",   null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  # t.index ["trial_id"], name: "index_tasks_on_trial_id", using: :btree

  # validations
  validates :number, :content, :deadline, :trial, presence: true
  validates :number, uniqueness: { scope: :trial }

  # relations
  belongs_to :trial

  # scopes
  default_scope { order(:number) }

  # callbacks
  before_validation :set_initial_number, on: :create
  after_save      :pending_changes_set!, unless: :trial_newly_created?

  # other instance methods
  has_paper_trail unless: :trial_newly_created?

  private

  def trial_newly_created?
    trial.created?
  end

  def pending_changes_set!
    trial.pending_changes_set!
  end

  def set_initial_number
    self.number ||= 1 + (trial&.tasks&.second_to_last&.number || 0)
  end
end
