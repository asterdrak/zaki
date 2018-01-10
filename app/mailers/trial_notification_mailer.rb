# frozen_string_literal: true
class TrialNotificationMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.trial_notification_mailer.new.subject
  #
  def created(trial, private_key)
    @title = t('mailer.title')
    @greeting = t('mailer.greeting')
    @link_info = t('mailer.link_info')
    @key_info = t('mailer.key_info')
    @trial = trial
    @private_key = private_key

    mail(to: trial.email, subject: @title)
  end
end
