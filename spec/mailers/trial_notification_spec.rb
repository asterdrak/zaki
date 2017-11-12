# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TrialNotificationMailer, type: :mailer do
  describe 'new' do
    let(:trial) { create(:trial) }
    let(:mail) { TrialNotificationMailer.created(trial, 'private_key') }

    it 'renders the headers' do
      expect(mail.subject).to eq('New trial notification')
      expect(mail.to).to eq([trial.email])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Thanks')
    end
  end
end
