# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'trials/edit', type: :view do
  before(:each) do
    @trial = assign(:trial, create(:trial))
  end

  it 'renders the edit trial form' do
    render

    assert_select 'form[action=?][method=?]', trial_path(@trial), 'post' do
      assert_select 'input#trial_title[name=?]', 'trial[title]'
    end
  end
end
