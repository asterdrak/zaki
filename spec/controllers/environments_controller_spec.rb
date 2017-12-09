# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EnvironmentsController, type: :controller do
  let(:committee) { create(:committee) }
  let(:environment) { create(:environment, committee: committee) }

  let(:invalid_attributes) { attributes_for(:environment, name: nil) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CommitteesController. Be sure to keep this updated too.
  let(:valid_session) { { user_id: create(:user) } }
  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Environment' do
        expect do
          post :create, params: { committee_id: committee.to_param,
                                  environment: attributes_for(:environment) },
                        session: valid_session
        end.to change(Environment, :count).by(1)
      end

      it 'assigns a newly created environment as @environment' do
        post :create, params: { committee_id: committee.to_param,
                                environment: attributes_for(:environment) },
                      session: valid_session
        expect(assigns(:environment)).to be_a(Environment)
        expect(assigns(:environment)).to be_persisted
      end

      it 'redirects to the created environment' do
        post :create, params: { committee_id: committee.to_param,
                                environment: attributes_for(:environment) },
                      session: valid_session
        expect(response).to redirect_to([:edit, committee])
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved environment as @environment' do
        post :create, params: { committee_id: committee.to_param,
                                environment: invalid_attributes },
                      session: valid_session
        expect(assigns(:environment)).to be_a_new(Environment)
      end

      it 're-redirects to committee edit' do
        post :create, params: { committee_id: committee.to_param,
                                environment: invalid_attributes },
                      session: valid_session
        expect(response).to redirect_to([:edit, committee])
      end
    end
  end
end
