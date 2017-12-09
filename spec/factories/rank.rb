# frozen_string_literal: true

require 'rails_helper'

FactoryGirl.define do
  factory :rank do
    sequence :name do |n|
      "rank name#{n}"
    end
    committee
  end
end
