# frozen_string_literal: true
module ApplicationHelper
  def current_user
    return nil unless session[:user_id]
    @current_user ||= User.find_by(uid: session[:user_id]['uid'])
  end
end
