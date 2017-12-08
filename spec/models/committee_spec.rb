# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Committee, type: :model do
  it { is_expected.to validate_presence_of :name }
  # it { is_expected.to validate_uniqueness_of :name }
  # it { is_expected.to validate_presence_of :stateman }

  it { is_expected.to have_many(:trials) }
  it { is_expected.to have_one(:stateman) }
  it { is_expected.to have_many(:ranks) }

  it 'triggers create_stateman_resources on create' do
    committee = Committee.allocate
    expect(committee).to receive(:create_stateman_resources)
    committee.send(:initialize)
    committee.name = 'name1'
    committee.save
  end
end
