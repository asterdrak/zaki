# frozen_string_literal: true

require 'rails_helper'

FactoryGirl.define do
  factory :environment do
    sequence :name do |n|
      "environment name#{n}"
    end
    committee
    supervisor_name   'Supervisor Name'
    supervisor_email  'supervisor@email.com3x'
    notify_supervisor 0
  end
end
