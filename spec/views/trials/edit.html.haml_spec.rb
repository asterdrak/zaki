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
      assert_select 'select#trial_deadline_1i[name=?]', 'trial[deadline(1i)]'
      assert_select 'select#trial_deadline_2i[name=?]', 'trial[deadline(2i)]'
      assert_select 'select#trial_status[name=?]', 'trial[status]'
    end
  end
end
