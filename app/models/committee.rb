# frozen_string_literal: true
class Committee < ApplicationRecord
  # t.string   "name",       null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  # t.index ["name"], name: "index_committees_on_name", unique: true, using: :btree

  # validations
  validates :name, presence: true, uniqueness: true

  # relations
  has_many :trials
end
