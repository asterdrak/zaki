# frozen_string_literal: true
module ApplicationHelper
  def current_user
    # TODO: secure from admin? called on nil value
    return nil unless session[:user_id]
    refresh_session if session_expired?
    @current_user ||= User.find_by(uid: session[:user_id]['uid'])
                          .decorate(session[:user_id]['extra'])
  end

  # rubocop:disable LineLength
  def formsub_meetings_url
    "#{Rails.application.secrets.formsub_url}/committees/#{@committee.formsub_committee_id}/meetings" + (current_user.present? ? '' : '?force_permitted_keyword_get=true')
  end

  def formsub_committee_url
    "#{Rails.application.secrets.formsub_url}/committees/#{@committee.formsub_committee_id}" + (current_user.present? ? '' : '?force_permitted_keyword_get=true')
  end
  # rubocop:enable LineLength

  def any_permitted_trials_created?
    Trial.where(private_key_digest: session[:permitted_trials], status: 'created').any?
  end

  private

  def session_expired?
    session_expires_at = session[:user_id]['credentials']['expires_at'].to_s
    session[:user_id] && Time.strptime(session_expires_at, '%s') < Time.zone.now
  end

  def refresh_session
    return if @return_flag.present?
    @return_flag = true

    access_token = session[:user_id]['credentials']['token']
    refresh_token = session[:user_id]['credentials']['refresh_token']

    access_token = OAuth2::AccessToken.new(oauth_client, access_token, refresh_token: refresh_token)

    token_refreshed = access_token.refresh!
    session[:user_id]['credentials'].update(expires_at: token_refreshed.expires_at,
                                            refresh_token: token_refreshed.refresh_token)
  end

  def oauth_client
    ::OAuth2::Client.new(oauth_options.client_id, oauth_options.client_secret,
                         oauth_options.client_options)
  end

  def oauth_options
    @options ||= OmniAuth::Strategies::Sso.default_options.update(
      client_id: Rails.application.secrets.sso_app_id,
      client_secret: Rails.application.secrets.sso_app_secret
    )
  end
end
