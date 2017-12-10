# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'committees/new', type: :view do
  before(:each) do
    assign(:committee, build(:committee))
    allow(view).to receive(:action_name) { 'new' }
  end

  it 'renders new committee form' do
    render

    assert_select 'form[action=?][method=?]', committees_path, 'post' do
      assert_select 'input#committee_name[name=?]', 'committee[name]'
    end
  end
end
