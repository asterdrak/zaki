# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'committees/show', type: :view do
  before(:each) do
    @committee = assign(:committee, create(:committee))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
  end
end
