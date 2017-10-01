# frozen_string_literal: true
json.extract! trial, :id, :title, :created_at, :updated_at
json.url trial_url(trial, format: :json)
