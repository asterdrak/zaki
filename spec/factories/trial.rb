# frozen_string_literal: true

require 'rails_helper'

FactoryGirl.define do
  factory :trial do
    sequence :title do |n|
      "trial title#{n}"
    end

    association :committee
  end
end
