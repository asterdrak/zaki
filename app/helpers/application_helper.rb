# frozen_string_literal: true
module ApplicationHelper
  def current_user
    # TODO: secure from admin? called on nil value
    return nil unless session[:user_id]
    @current_user ||= User.find_by(uid: session[:user_id]['uid'])
                          .decorate(session[:user_id]['extra'])
  end

  # rubocop:disable LineLength
  def formsub_meetings_url
    "#{Rails.application.secrets.formsub_url}/committees/#{@committee.formsub_committee_id}/meetings?force_permitted_keyword_get=true"
  end

  def formsub_committee_url
    "#{Rails.application.secrets.formsub_url}/committees/#{@committee.formsub_committee_id}?force_permitted_keyword_get=true"
  end
  # rubocop:enable LineLength
end
