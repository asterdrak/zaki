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
    supervisor_email 'fake_sup@mail.com'
    supervisor_phone_number '4445778846'
    private_key     'Key'
    association     :rank
    association     :environment
    troop           'Sample troop'
    formal_conditions true
    birthdate 15.years.ago

    to_create { |instance| instance.save(validate: false) }
  end
end
