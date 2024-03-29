# frozen_string_literal: true
module TrialAuthorizer
  def skip_committee_auth
    current_user.blank? && skip_auth_actions.include?(action_name)
  end

  def set_session_permitted_trials
    session['permitted_trials'] = [] if session['permitted_trials'].nil?
  end

  def trial_authorized?
    current_user || session['permitted_trials']&.include?(@trial.private_key_digest)
  end

  def render_private_key_monit
    render 'private_key_monit'
  end
end
