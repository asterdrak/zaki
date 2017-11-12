# frozen_string_literal: true
require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe TrialsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # trial. As you add validations to trial, be sure to
  # adjust the attributes here as well.
  let(:committee) { create(:committee) }
  let(:trial) { create(:trial, committee: committee) }

  let(:invalid_attributes) { attributes_for(:trial, title: nil) }

  let(:trial) { create(:trial) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TrialsController. Be sure to keep this updated too.
  let(:valid_session) { { user_id: create(:user) } }

  describe 'GET #index' do
    before { allow(StatemanOrganization).to receive(:find) { OpenStruct.new(stateman_trials: []) } }

    it 'assigns all trials as @trials' do
      get :index, params: { committee_id: trial.committee.id }, session: valid_session
      expect(assigns(:trials)).to eq([trial])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested trial as @trial' do
      get :show, params: { committee_id: committee.id, id: trial.to_param }, session: valid_session
      expect(assigns(:trial)).to eq(trial)
    end
  end

  describe 'GET #new' do
    it 'assigns a new trial as @trial' do
      get :new, params: { committee_id: committee.id }, session: valid_session
      expect(assigns(:trial)).to be_a_new(Trial)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested trial as @trial' do
      get :edit, params: { committee_id: committee.id, id: trial.to_param }, session: valid_session
      expect(assigns(:trial)).to eq(trial)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new trial' do
        expect do
          post :create, params: { committee_id: committee.id, trial: attributes_for(:trial) },
                        session: valid_session
        end.to change(Trial, :count).by(1)
      end

      it 'assigns a newly created trial as @trial' do
        post :create, params: { committee_id: committee.id, trial: attributes_for(:trial) },
                      session: valid_session
        expect(assigns(:trial)).to be_a(Trial)
        expect(assigns(:trial)).to be_persisted
      end

      it 'redirects to the created trial' do
        post :create, params: { committee_id: committee.id, trial: attributes_for(:trial) },
                      session: valid_session
        expect(response).to redirect_to([committee, Trial.last])
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved trial as @trial' do
        post :create, params: { committee_id: committee.id, trial: invalid_attributes },
                      session: valid_session
        expect(assigns(:trial)).to be_a_new(Trial)
      end

      it "re-renders the 'new' template" do
        post :create, params: { committee_id: committee.id, trial: invalid_attributes },
                      session: valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { attributes_for(:trial) }

      it 'updates the requested trial' do
        put :update, params: { committee_id: committee.id, id: trial.to_param,
                               trial: new_attributes }, session: valid_session
        trial.reload
        expect(trial.title).to eq(new_attributes[:title])
      end

      it 'assigns the requested trial as @trial' do
        put :update, params: { committee_id: committee.id, id: trial.to_param,
                               trial: attributes_for(:trial) }, session: valid_session
        expect(assigns(:trial)).to eq(trial)
      end

      it 'redirects to the trial' do
        put :update, params: { committee_id: committee.id, id: trial.to_param,
                               trial: attributes_for(:trial) }, session: valid_session
        expect(response).to redirect_to([committee, trial])
      end
    end

    context 'with invalid params' do
      it 'assigns the trial as @trial' do
        put :update, params: { committee_id: committee.id, id: trial.to_param,
                               trial: invalid_attributes }, session: valid_session
        expect(assigns(:trial)).to eq(trial)
      end

      it "re-renders the 'edit' template" do
        put :update, params: { committee_id: committee.id, id: trial.to_param,
                               trial: invalid_attributes }, session: valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { create(:trial) }

    it 'destroys the requested trial' do
      expect do
        delete :destroy, params: { committee_id: committee.id, id: Trial.last.to_param },
                         session: valid_session
      end.to change(Trial, :count).by(-1)
    end

    it 'redirects to the trials list' do
      delete :destroy, params: { committee_id: committee.id, id: Trial.last.to_param },
                       session: valid_session
      expect(response).to redirect_to(committee_trials_url(committee))
    end
  end
end
