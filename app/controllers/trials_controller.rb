# frozen_string_literal: true
class TrialsController < ApplicationController
  before_action :set_trial, only: [:show, :edit, :update, :destroy]
  before_action :set_committee

  # GET /trials
  # GET /trials.json
  def index
    @trials = @committee.trials
  end

  # GET /trials/1
  # GET /trials/1.json
  def show; end

  # GET /trials/new
  def new
    @trial = Trial.new
  end

  # GET /trials/1/edit
  def edit; end

  # POST /trials
  # POST /trials.json
  def create
    @trial = Trial.new(trial_params)
    @trial.committee = @committee

    respond_to do |format|
      if @trial.save
        format.html { redirect_to [@committee, @trial], notice: 'trial was successfully created.' }
        format.json { render :show, status: :created, location: @trial }
      else
        format.html { render :new }
        format.json { render json: @trial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trials/1
  # PATCH/PUT /trials/1.json
  def update
    respond_to do |format|
      if @trial.update(trial_params)
        format.html do
          redirect_to @trial.referer || [@committee, @trial],
                      notice: 'trial was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @trial }
      else
        format.html { render :edit }
        format.json { render json: @trial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trials/1
  # DELETE /trials/1.json
  def destroy
    @trial.destroy
    respond_to do |format|
      format.html do
        redirect_to committee_trials_url(@committee),
                    notice: 'trial was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trial
    @trial = Trial.find(params[:id])
  end

  def set_committee
    @committee = Committee.find(params[:committee_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def trial_params
    params.require(:trial).permit(:title, :deadline, :status, :referer)
  end
end
