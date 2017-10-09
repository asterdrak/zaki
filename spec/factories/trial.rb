# frozen_string_literal: true

require 'rails_helper'

FactoryGirl.define do
  factory :trial do
    sequence :title do |n|
      "trial title#{n}"
    end

    association     :committee
    deadline        Time.zone.now
    email           'fake@gmail.com'
    phone_number    '667582231'
    supervisor      'pwd. Marcin Marciniak'
    environment     'Szczep Wichry'
  end
end
