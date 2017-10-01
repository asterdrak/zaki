# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'trials/new', type: :view do
  before(:each) do
    assign(:trial, build(:trial))
  end

  it 'renders new trial form' do
    render

    assert_select 'form[action=?][method=?]', trials_path, 'post' do
      assert_select 'input#trial_title[name=?]', 'trial[title]'
    end
  end
end
