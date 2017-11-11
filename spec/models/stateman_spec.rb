# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Stateman, type: :model do
  it { is_expected.to validate_presence_of(:committee) }
  it { is_expected.to validate_presence_of(:organization_id) }
  it { is_expected.to belong_to(:committee) }

  describe '#organization' do
    let(:stateman) { create(:stateman) }

    it 'calls StatemanOrganization find method' do
      expect(StatemanOrganization).to receive(:find).with('1')
      stateman.organization
    end
  end
end
