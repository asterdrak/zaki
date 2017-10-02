# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Trial, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:committee) }
  it { is_expected.to validate_inclusion_of(:status).in_array(Trial::STATUSES) }

  # it { is_expected.to validate_uniqueness_of(:title) }

  it { is_expected.to belong_to(:committee) }

  describe 'status scopes and instance methods' do
    describe 'pending' do
      let(:trial) { create(:trial) } # default pending

      it 'new trial is in pending scope' do
        expect(Trial.pending).to include(trial)
      end

      it 'new trial is pending' do
        expect(trial.pending?).to be true
      end
    end

    describe 'rejected' do
      let(:rejected_trial) { create(:trial, status: 'rejected') }

      it 'rejected trial is in rejected scope' do
        expect(Trial.rejected).to include(rejected_trial)
      end

      it 'rejected trial is rejected' do
        expect(rejected_trial.rejected?).to be true
      end
    end

    describe 'accepted' do
      let(:accepted_trial) { create(:trial, status: 'accepted') }

      it 'accepted trial is in accepted scope' do
        expect(Trial.accepted).to include(accepted_trial)
      end

      it 'accepted trial is accepted' do
        expect(accepted_trial.accepted?).to be true
      end
    end
  end

  describe 'pending trials' do
    let(:ongoing_trial) { create(:trial, deadline: 1.year.from_now) }
    let(:overdue_soon_trial) { create(:trial, deadline: 2.weeks.from_now) }
    let(:overdue_trial) { create(:trial, deadline: 2.weeks.ago) }

    it 'ongoing trial' do
      expect(Trial.ongoing).to include(ongoing_trial)
    end

    it 'ongoing trial includes overdue soon' do
      expect(Trial.ongoing).to include(overdue_soon_trial)
    end

    it 'ongoing trial doesnt include overdued' do
      expect(Trial.ongoing).to_not include(overdue_trial)
    end

    it 'overdue soon trial' do
      expect(Trial.overdue_soon).to include(overdue_soon_trial)
    end

    it 'overdue soon trial doesnt include trial with one year dealine' do
      expect(Trial.overdue_soon).to_not include(ongoing_trial)
    end

    it 'overdue trial' do
      expect(Trial.overdue).to include(overdue_trial)
    end

    it 'overdue trial doesnt include ongoing trial' do
      expect(Trial.overdue).to_not include(ongoing_trial)
    end

    it 'overdue trial include overdue soon trial' do
      expect(Trial.overdue).to_not include(overdue_soon_trial)
    end
  end
end
