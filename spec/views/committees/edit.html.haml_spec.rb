# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'committees/edit', type: :view do
  before(:each) do
    @committee = assign(:committee, create(:committee))
  end

  it 'renders the edit committee form' do
    render

    assert_select 'form[action=?][method=?]', committee_path(@committee), 'post' do
      assert_select 'input#committee_name[name=?]', 'committee[name]'
    end
  end
end
