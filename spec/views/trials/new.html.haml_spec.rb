# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'trials/new', type: :view do
  before(:each) do
    assign(:trial, build(:trial))
    @committee = create(:committee)
    allow(view).to receive(:action_name).and_return('new')
  end

  it 'renders new trial form' do
    render

    assert_select 'form[action=?][method=?]', committee_trials_path(@committee), 'post' do
      assert_select 'input#trial_title[name=?]', 'trial[title]'
      assert_select 'select#trial_deadline_1i[name=?]', 'trial[deadline(1i)]'
      assert_select 'select#trial_deadline_2i[name=?]', 'trial[deadline(2i)]'
      assert_select 'select#trial_status[name=?]', 'trial[status]', count: 0
      assert_select 'input#trial_email[name=?]', 'trial[email]'
      assert_select 'input#trial_phone_number[name=?]', 'trial[phone_number]'
      assert_select 'input#trial_supervisor[name=?]', 'trial[supervisor]'
      assert_select 'input#trial_environment[name=?]', 'trial[environment]'
    end
  end
end
