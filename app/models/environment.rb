# frozen_string_literal: true
class Environment < ApplicationRecord
  # t.string   "name",              null: false
  # t.string   "supervisor_name"
  # t.string   "supervisor_email"
  # t.boolean  "notify_supervisor"
  # t.integer  "committee_id",      null: false
  # t.datetime "created_at",        null: false
  # t.datetime "updated_at",        null: false
  # t.index ["committee_id"], name: "index_environments_on_committee_id", using: :btree

  # validations
  validates :name, :committee, presence: true
  validates :name, uniqueness: { scope: :committee }

  # relations
  belongs_to :committee
end
