# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'trials', type: :request do
  describe 'GET /trials' do
    let(:committee) { create(:committee) }
    before do
      allow(StatemanOrganization).to receive(:find) { OpenStruct.new(stateman_trials: []) }
      allow_any_instance_of(ApplicationHelper).to receive(:current_user) { create(:user) }
    end

    it 'works! (now write some real specs)' do
      get committee_trials_path(committee)
      expect(response).to have_http_status(200)
    end
  end
end
