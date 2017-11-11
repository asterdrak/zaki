# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'trials/show', type: :view do
  before(:each) do
    @trial = assign(:trial, create(:trial))
    @committee = @trial.committee
    allow(@trial).to receive_message_chain('stateman_trial.state.name')
    allow(@trial).to receive_message_chain('stateman_trial.reachable_states') { [] }

    allow_any_instance_of(TrialsHelper).to receive(:style_for_trial_badge)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(@trial.title)
    expect(rendered).to match(@trial.status)
    expect(rendered).to match(@trial.email)
    expect(rendered).to match(@trial.phone_number)
    expect(rendered).to match(@trial.supervisor)
    expect(rendered).to match(@trial.environment)
  end
end
