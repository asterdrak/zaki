# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'trials/index', type: :view do
  let(:trial_list) { create_list(:trial, 2) }

  before(:each) do
    assign(:trials, trial_list)
    @committee = create(:committee)
  end

  it 'renders a list of trials' do
    render
    trial_list.each do |trial|
      assert_select 'tr>td', text: trial.title
    end
  end
end
