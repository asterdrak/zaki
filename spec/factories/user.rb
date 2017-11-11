# frozen_string_literal: true

require 'rails_helper'

FactoryGirl.define do
  factory :user do
    sequence :uid do |n|
      n
    end
    sequence :email do |n|
      "email#{n}@gmail.com"
    end
  end
end
