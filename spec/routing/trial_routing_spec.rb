# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TrialsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'committees/1/trials').to route_to('trials#index', committee_id: '1')
    end

    it 'routes to #new' do
      expect(get: 'committees/1/trials/new').to route_to('trials#new', committee_id: '1')
    end

    it 'routes to #show' do
      expect(get: 'committees/1/trials/1').to route_to('trials#show', id: '1',
                                                                      committee_id: '1')
    end

    it 'routes to #edit' do
      expect(get: 'committees/1/trials/1/edit').to route_to('trials#edit', id: '1',
                                                                           committee_id: '1')
    end

    it 'routes to #create' do
      expect(post: 'committees/1/trials').to route_to('trials#create', committee_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: 'committees/1/trials/1').to route_to('trials#update', id: '1', committee_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'committees/1/trials/1').to route_to('trials#update', id: '1',
                                                                          committee_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'committees/1/trials/1').to route_to('trials#destroy', id: '1',
                                                                            committee_id: '1')
    end
  end
end
