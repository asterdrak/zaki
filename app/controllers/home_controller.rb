# frozen_string_literal: true
class HomeController < ApplicationController
  skip_before_action :login_required, only: [:index, :permitted_keywords]
  skip_committee_actions

  def index
    redirect_to committees_path if current_user.present?
  end

  def private_index; end

  def permitted_keywords
    respond_to do |format|
      format.json do
        message = '&alert=' + URI.escape(t(:no_trials_found)) if session[:permitted_trials].blank?
        message = '&alert=' + URI.escape(t(:trial_created_error)) if any_permitted_trials_created?
        redirect_to Rails.application.secrets.formsub_url + '/set_permitted_keywords?keywords=' +
                    URI.escape(Trial.pending.where(private_key_digest: session[:permitted_trials])
                                    .pluck(:formsub_case_keyword).compact.to_json) + message.to_s
      end
      format.html { head :no_content }
    end
  end
end
