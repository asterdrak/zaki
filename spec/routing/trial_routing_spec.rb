# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TrialsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/trials').to route_to('trials#index')
    end

    it 'routes to #new' do
      expect(get: '/trials/new').to route_to('trials#new')
    end

    it 'routes to #show' do
      expect(get: '/trials/1').to route_to('trials#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/trials/1/edit').to route_to('trials#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/trials').to route_to('trials#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/trials/1').to route_to('trials#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/trials/1').to route_to('trials#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/trials/1').to route_to('trials#destroy', id: '1')
    end
  end
end
