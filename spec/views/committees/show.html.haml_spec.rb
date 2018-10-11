# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'committees/show', type: :view do
  let(:committee) { create(:committee) }

  let(:user) do
    create(:user).decorate('permissions' => { 'zaki' => { 'committee' => [committee.id] } })
  end

  before(:each) do
    @committee = assign(:committee, committee)
    allow(@committee).to receive_message_chain('formsub_committee.meetings') { [] }
    @state_trial_count = []

    without_partial_double_verification do
      allow(view).to receive(:current_user) { user }
      allow(view).to receive(:policy) { |record| Pundit.policy(user, record) }
    end
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(@committee.name)
  end
end
