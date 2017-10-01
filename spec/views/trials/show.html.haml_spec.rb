# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'trials/show', type: :view do
  before(:each) do
    @trial = assign(:trial, create(:trial))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
  end
end
