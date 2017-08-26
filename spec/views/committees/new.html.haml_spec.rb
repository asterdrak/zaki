# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'committees/new', type: :view do
  before(:each) do
    assign(:committee, Committee.new(
                         name: 'MyString'
    ))
  end

  it 'renders new committee form' do
    render

    assert_select 'form[action=?][method=?]', committees_path, 'post' do
      assert_select 'input#committee_name[name=?]', 'committee[name]'
    end
  end
end
