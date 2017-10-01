# frozen_string_literal: true
class Trial < ApplicationRecord
  # t.string   "title",      null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

  # validations
  validates :title, presence: true, uniqueness: true
end
