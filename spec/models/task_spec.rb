# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:trial) { create(:trial) }
  subject { trial.tasks.new }

  # it { is_expected.to validate_presence_of(:number) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_presence_of(:deadline) }

  context 'trial empty' do
    subject { Task.new }
    it { is_expected.to validate_presence_of(:trial) }
  end
end
