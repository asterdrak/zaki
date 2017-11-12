# frozen_string_literal: true
class TrialNotificationMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.trial_notification_mailer.new.subject
  #
  def created(trial, private_key)
    @title = 'New trial notification'
    @greeting = 'Thanks for creating trial.'
    @link_info = 'You can access your trial with this link:'
    @key_info = 'Your private key:'
    @trial = trial
    @private_key = private_key

    mail(to: trial.email, subject: @title)
  end
end
