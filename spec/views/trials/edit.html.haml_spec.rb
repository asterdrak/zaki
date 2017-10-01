# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'trials/edit', type: :view do
  before(:each) do
    @trial = assign(:trial, create(:trial))
    @committee = assign(:committee, @trial.committee)
  end

  it 'renders the edit trial form' do
    render

    assert_select 'form[action=?][method=?]', committee_trial_path(@committee, @trial), 'post' do
      assert_select 'input#trial_title[name=?]', 'trial[title]'
    end
  end
end
