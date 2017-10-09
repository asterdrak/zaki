# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'trials/index', type: :view do
  context 'without trials set' do
    before(:each) do
      @committee = create(:committee)
      @trial_list = create_list(:trial, 2, committee: @committee)
      assign(:trials, @committee.trials)
    end

    it 'renders a list of trials' do
      render
      @trial_list.each do |trial|
        assert_select 'tr>td', text: trial.title
      end
    end
  end

  context 'without trials set' do
    before(:each) do
      @committee = create(:committee)
      assign(:trials, Trial.all)
    end

    it 'renders a list of trials' do
      render
      assert_select 'h3', text: 'No trials yet'
    end
  end
end
