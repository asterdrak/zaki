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

  describe 'GET #edit' do
    it 'assigns the requested environment as @environment' do
      get :edit, params: { committee_id: committee.to_param,
                           id: environment.to_param }, session: valid_session
      expect(assigns(:environment)).to eq(environment)
    end
  end

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
        expect(response).to redirect_to([:edit, committee, Environment.last])
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

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        attributes_for(:environment)
      end

      it 'updates the requested environment' do
        put :update, params: { committee_id: committee.to_param, id: environment.to_param,
                               environment: new_attributes },
                     session: valid_session
        environment.reload
        expect(environment.name).to eq(new_attributes[:name])
      end

      it 'assigns the requested environment as @environment' do
        put :update, params: { committee_id: committee.to_param, id: environment.to_param,
                               environment: attributes_for(:environment) },
                     session: valid_session
        expect(assigns(:environment)).to eq(environment)
      end

      it 'redirects to the environment' do
        put :update, params: { committee_id: committee.to_param, id: environment.to_param,
                               environment: attributes_for(:environment) },
                     session: valid_session
        expect(response).to redirect_to([:edit, committee])
      end
    end

    context 'with invalid params' do
      it 'assigns the environment as @environment' do
        put :update, params: { committee_id: committee.to_param, id: environment.to_param,
                               environment: invalid_attributes },
                     session: valid_session
        expect(assigns(:environment)).to eq(environment)
      end

      it "re-renders the 'edit' template" do
        put :update, params: { committee_id: committee.to_param, id: environment.to_param,
                               environment: invalid_attributes },
                     session: valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { create(:environment, committee: committee) }

    it 'destroys the requested environment' do
      expect do
        delete :destroy, params: { committee_id: committee.to_param,
                                   id: Environment.last.to_param }, session: valid_session
      end.to change(Environment, :count).by(-1)
    end

    it 'redirects to the committees list' do
      delete :destroy, params: { committee_id: committee.to_param,
                                 id: Environment.last.to_param }, session: valid_session
      expect(response).to redirect_to([:edit, committee])
    end
  end
end
