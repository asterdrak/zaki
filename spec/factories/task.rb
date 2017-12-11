# frozen_string_literal: true

require 'rails_helper'

FactoryGirl.define do
  factory :task do
    sequence :number do |n|
      n
    end

    association :trial
    sequence :content do |n|
      "task content#{n}"
    end
    deadline 2.months.from_now
  end
end
