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
    environment     'Szczep Wichry'
    private_key     'Key'

    to_create { |instance| instance.save(validate: false) }
  end
end
