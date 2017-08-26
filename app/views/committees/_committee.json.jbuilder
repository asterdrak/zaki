# frozen_string_literal: true
json.extract! committee, :id, :name, :created_at, :updated_at
json.url committee_url(committee, format: :json)
