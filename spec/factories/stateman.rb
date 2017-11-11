# frozen_string_literal: true

require 'rails_helper'

FactoryGirl.define do
  factory :stateman do
    organization_id 1
    committee
  end
end
