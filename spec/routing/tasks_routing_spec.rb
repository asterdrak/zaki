# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TasksController, type: :routing do
  describe 'routing' do
    it 'routes to #edit' do
      expect(get: 'committees/1/trials/1/tasks/1/edit').to route_to('tasks#edit', id: '1',
                                                                                  committee_id: '1',
                                                                                  trial_id: '1')
    end

    it 'routes to #create' do
      expect(post: 'committees/1/trials/1/tasks').to route_to('tasks#create', committee_id: '1',
                                                                              trial_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: 'committees/1/trials/1/tasks/1').to route_to('tasks#update', id: '1',
                                                                               committee_id: '1',
                                                                               trial_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'committees/1/trials/1/tasks/1').to route_to('tasks#update', id: '1',
                                                                                 committee_id: '1',
                                                                                 trial_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'committees/1/trials/1/tasks/1').to route_to('tasks#destroy',
                                                                  id: '1',
                                                                  committee_id: '1',
                                                                  trial_id: '1')
    end
  end
end
