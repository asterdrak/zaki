# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'trials/index', type: :view do
  before(:each) do
    @committee = create(:committee)
    @trial_list = create_list(:trial, 2, committee: @committee)
    @committee.reload
    assign(:trials, @committee.trials)
  end

  it 'renders a list of trials' do
    render
    @trial_list.each do |trial|
      assert_select 'tr>td', text: trial.title
    end
  end
end
