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

  # relations
  belongs_to :committee
end
