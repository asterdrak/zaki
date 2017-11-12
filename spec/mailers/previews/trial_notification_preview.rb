# frozen_string_literal: true
# Preview all emails at http://localhost:3033/rails/mailers/trial_notification
class TrialNotificationPreview < ActionMailer::Preview
  # include ApplicationHelper

  # Preview this email at http://localhost:3033/rails/mailers/trial_notification/created
  def created
    trial = Trial.last
    TrialNotificationMailer.created(trial, 'private_key')
  end
end
