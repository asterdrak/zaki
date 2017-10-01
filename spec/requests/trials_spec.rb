# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'trials', type: :request do
  describe 'GET /trials' do
    it 'works! (now write some real specs)' do
      get trials_path
      expect(response).to have_http_status(200)
    end
  end
end
