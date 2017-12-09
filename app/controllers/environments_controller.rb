# frozen_string_literal: true
class EnvironmentsController < ApplicationController
  before_action :set_committee
  # POST /environments
  # POST /environments.json
  def create
    @environment = @committee.environments.new(environment_params)

    respond_to do |format|
      if @environment.save
        format.html do
          redirect_to [:edit, @committee],
                      notice: t(:environment_successfully_created)
        end
        format.json { render :show, status: :created, location: @environment }
      else
        format.html do
          redirect_to [:edit, @committee], alert: @environment.errors.full_messages.to_sentence
        end
        format.json { render json: @environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /environments/1
  # DELETE /environments/1.json
  def destroy
    @environment = @committee.environments.find(params[:id]).destroy
    respond_to do |format|
      format.html do
        redirect_to [:edit, @committee],
                    notice: t(:environment_successfully_destroyed)
      end
      format.json { head :no_content }
    end
  end

  private

  def set_committee
    @committee = Committee.find(params[:committee_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def environment_params
    params.require(:environment).permit(:name)
  end
end
