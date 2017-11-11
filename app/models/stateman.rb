# frozen_string_literal: true
class Stateman < ApplicationRecord
  # t.string   "organization_id",                 null: false
  # t.integer  "committee_id",                    null: false
  # t.boolean  "trials_created",  default: false, null: false
  # t.boolean  "tasks_created",   default: false, null: false
  # t.datetime "created_at",                      null: false
  # t.datetime "updated_at",                      null: false
  # t.index ["committee_id"], name: "index_statemen_on_committee_id", using: :btree

  # validations
  validates :organization_id, :committee, presence: true

  # relations
  belongs_to :committee

  # rest instance methods
  def organization
    StatemanOrganization.find(organization_id)
  end
end
