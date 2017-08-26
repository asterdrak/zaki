# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'committees/index', type: :view do
  let(:committee_list) { create_list(:committee, 2) }

  before(:each) do
    assign(:committees, committee_list)
  end

  it 'renders a list of committees' do
    render
    committee_list.each do |committee|
      assert_select 'tr>td', text: committee.name
    end
  end
end
