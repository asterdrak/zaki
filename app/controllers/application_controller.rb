# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception
  before_action :login_required

  rescue_from ActiveRecord::DeleteRestrictionError do |exception|
    redirect_to(:back, alert: exception.message)
  end

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
end
