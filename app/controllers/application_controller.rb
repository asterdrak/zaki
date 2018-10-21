# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit

  protect_from_forgery with: :exception
  before_action :login_required

  before_action :set_committee
  before_action :authorize_committee, unless: :skip_committee_auth
  # TODO: potentially dangerous, we should remove below unless and use TrialPolicy
  after_action :verify_authorized, unless: :skip_committee_auth

  before_action :set_paper_trail_whodunnit

  rescue_from ActiveRecord::DeleteRestrictionError do |exception|
    redirect_to(:back, alert: exception.message)
  end

  rescue_from OAuth2::Error do |_exception|
    session[:user_id] = nil
    redirect_to root_path, alert: I18n.t(:login_error)
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def self.skip_committee_actions
    skip_before_action :set_committee, :authorize_committee
    skip_after_action :verify_authorized
  end

  protected

  def login_required
    return if current_user
    respond_to do |format|
      format.html do
        redirect_to '/auth/sso'
      end
      format.json do
        render json: { 'error' => 'Access Denied' }.to_json
      end
    end
  end

  def skip_committee_auth
    false
  end

  private

  def user_not_authorized
    redirect_to(request.referer || root_path, alert: t(:not_authorized_alert))
  end

  def set_committee
    @committee = Committee.find(params[:committee_id])
  end

  def authorize_committee
    authorize @committee || Committee, :use?
  end
end
