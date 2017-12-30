# frozen_string_literal: true
require 'rails_helper'

RSpec.describe RanksController, type: :controller do
  let(:committee) { create(:committee) }
  let(:rank) { create(:rank, committee: committee) }

  let(:invalid_attributes) { attributes_for(:rank, name: nil) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CommitteesController. Be sure to keep this updated too.
  let(:valid_session) do
    { user_id: { 'uid' => create(:user).uid, 'extra' => {},
                 'credentials' => { 'expires_at' => 1.hour.from_now.to_i } } }
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Rank' do
        expect do
          post :create, params: { committee_id: committee.to_param, rank: attributes_for(:rank) },
                        session: valid_session
        end.to change(Rank, :count).by(1)
      end

      it 'assigns a newly created rank as @rank' do
        post :create, params: { committee_id: committee.to_param, rank: attributes_for(:rank) },
                      session: valid_session
        expect(assigns(:rank)).to be_a(Rank)
        expect(assigns(:rank)).to be_persisted
      end

      it 'redirects to the created rank' do
        post :create, params: { committee_id: committee.to_param, rank: attributes_for(:rank) },
                      session: valid_session
        expect(response).to redirect_to([:edit, committee])
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved rank as @rank' do
        post :create, params: { committee_id: committee.to_param, rank: invalid_attributes },
                      session: valid_session
        expect(assigns(:rank)).to be_a_new(Rank)
      end

      it 're-redirects to committee edit' do
        post :create, params: { committee_id: committee.to_param, rank: invalid_attributes },
                      session: valid_session
        expect(response).to redirect_to([:edit, committee])
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { create(:rank, committee: committee) }

    it 'destroys the requested rank' do
      expect do
        delete :destroy, params: { committee_id: committee.to_param,
                                   id: Rank.last.to_param }, session: valid_session
      end.to change(Rank, :count).by(-1)
    end

    it 'redirects to the committees list' do
      delete :destroy, params: { committee_id: committee.to_param,
                                 id: Rank.last.to_param }, session: valid_session
      expect(response).to redirect_to([:edit, committee])
    end
  end
end
