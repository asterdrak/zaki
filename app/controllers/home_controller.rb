# frozen_string_literal: true
class HomeController < ApplicationController
  skip_before_action :login_required, only: [:index, :permitted_keywords]

  def index
    redirect_to committees_path if current_user.present?
  end

  def private_index; end

  def permitted_keywords
    respond_to do |format|
      format.json do
        message = '&alert=' + URI.escape('No trials found.') if session[:permitted_trials].blank?
        redirect_to Rails.application.secrets.formsub_url + '/set_permitted_keywords?keywords=' +
                    URI.escape(Trial.where(private_key_digest: session[:permitted_trials])
                                    .pluck(:formsub_case_keyword).compact.to_json) + message.to_s
      end
      format.html { head :no_content }
    end
  end
end
