# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit

  protect_from_forgery with: :exception
  before_action :login_required

  before_action :set_paper_trail_whodunnit

  rescue_from ActiveRecord::DeleteRestrictionError do |exception|
    redirect_to(:back, alert: exception.message)
  end

  rescue_from OAuth2::Error do |_exception|
    session[:user_id] = nil
    redirect_to root_path, alert: I18n.t(:login_error)
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

  private

  def user_not_authorized
    redirect_to(request.referer || root_path, alert: t(:not_authorized_alert))
  end
end
