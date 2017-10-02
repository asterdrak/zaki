# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'trials', type: :request do
  describe 'GET /trials' do
    let(:committee) { create(:committee) }

    it 'works! (now write some real specs)' do
      get committee_trials_path(committee)
      expect(response).to have_http_status(200)
    end
  end
end
