# frozen_string_literal: true

require 'rails_helper'

FactoryGirl.define do
  factory :committee do
    sequence :name do |n|
      "committee name#{n}"
    end
  end
end
