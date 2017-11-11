# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Trial, type: :model do
  let(:committee) { create(:committee) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:committee) }
  it { is_expected.to validate_presence_of(:deadline) }
  it { is_expected.to validate_inclusion_of(:status).in_array(Trial::STATUSES) }

  # it { is_expected.to validate_uniqueness_of(:title) }

  describe 'email' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value('x@a.b').for(:email) }
    it { is_expected.not_to allow_value('xa.b').for(:email) }
  end

  describe 'phone_number' do
    it { is_expected.to allow_value('112554478').for(:phone_number) }
    it { is_expected.to allow_value('+48112554478').for(:phone_number) }
    it { is_expected.to allow_value('+481112554478').for(:phone_number) }
    it { is_expected.not_to allow_value('66587994').for(:phone_number) }
    it { is_expected.not_to allow_value('+4811244558771').for(:phone_number) }
  end

  it { is_expected.to validate_presence_of(:supervisor) }
  it { is_expected.to validate_presence_of(:environment) }

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

  describe 'callbacks' do
    it 'triggers create_stateman_trial after create' do
      # trial = Trial.new(attributes_for(:trial))
      trial = build(:trial, committee: committee)
      # trial.committee = committee
      expect(trial).to receive(:create_stateman_trial)
      trial.send(:save)
    end

    it 'triggers destroy_stateman_trial before destroy' do
      trial = create(:trial)
      expect(trial).to receive(:destroy_stateman_trial)
      trial.send(:destroy)
    end
  end

  describe '#stateman_trial' do
    it '' do
      trial = create(:trial)
      expect(StatemanTrial).to receive(:find)
      trial.stateman_trial
    end
  end
end
