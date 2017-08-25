class UserSessionsController < ApplicationController
  before_action :login_required, only: [:destroy]

  # omniauth callback method
  #
  # First the callback operation is done
  # inside OmniAuth and then this route is called
  def create
    omniauth = env['omniauth.auth']

    user = User.find_by(uid: omniauth['uid'])
    unless user
      # New user registration
      user = User.new(uid: omniauth['uid'])
    end
    user.email = omniauth['info']['email']
    user.save

    # p omniauth

    # Currently storing all the info
    session[:user_id] = omniauth

    flash[:notice] = 'Successfully logged in'
    redirect_to root_path
  end

  # Omniauth failure callback
  def failure
    flash[:notice] = params[:message]
  end

  # logout - Clear our rack session BUT essentially redirect to the provider
  # to clean up the Devise session from there too !
  def destroy
    session[:user_id] = nil

    flash[:notice] = 'You have successfully signed out!'
    redirect_to "#{CUSTOM_PROVIDER_URL}/users/sign_out"
  end
end
