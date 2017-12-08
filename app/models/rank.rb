# frozen_string_literal: true
class Rank < ApplicationRecord
  # t.string   "name",         null: false
  # t.integer  "committee_id", null: false
  # t.datetime "created_at",   null: false
  # t.datetime "updated_at",   null: false
  # t.index ["committee_id"], name: "index_ranks_on_committee_id", using: :btree

  # validations
  validates :name, :committee, presence: true
  validates :name, uniqueness: { scope: :committee }

  # relations
  belongs_to :committee
end
