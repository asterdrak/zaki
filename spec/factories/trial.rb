# frozen_string_literal: true

require 'rails_helper'

FactoryGirl.define do
  factory :trial do
    sequence :title do |n|
      "trial title#{n}"
    end

    association     :committee
    deadline        2.months.from_now
    email           'fake@gmail.com'
    phone_number    '667582231'
    supervisor      'pwd. Marcin Marciniak'
    private_key     'Key'
    association     :rank
    association     :environment
    formal_conditions true

    to_create { |instance| instance.save(validate: false) }
  end
end
