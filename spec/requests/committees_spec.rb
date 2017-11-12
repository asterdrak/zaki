# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Committees', type: :request do
  describe 'GET /committees' do
    before { allow_any_instance_of(ApplicationHelper).to receive(:current_user) { create(:user) } }

    it 'works! (now write some real specs)' do
      get committees_path
      expect(response).to have_http_status(200)
    end
  end
end
