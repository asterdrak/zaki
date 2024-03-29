# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'trials/show', type: :view do
  before(:each) do
    @trial = assign(:trial, create(:trial))
    @committee = @trial.committee
    @tasks = []
    @task = Task.new
    @comments = []
    allow(@trial).to receive_message_chain('stateman_trial.state.name') { 'name' }
    allow(@trial).to receive_message_chain('stateman_trial.state.description')
    allow(@trial).to receive_message_chain('stateman_trial.reachable_states') { [] }
    allow(@trial).to receive_message_chain('formsub_case.registrations') { [] }

    allow_any_instance_of(TrialsHelper).to receive(:style_for_trial_badge)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(@trial.title)
    expect(rendered).to match(@trial.email)
    expect(rendered).to match(@trial.phone_number)
    expect(rendered).to match(@trial.supervisor)
    expect(rendered).to match(@trial.environment.name)
  end
end
