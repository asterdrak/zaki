# frozen_string_literal: true
class TrialsController < ApplicationController
  before_action :set_trial, only: [:show, :edit, :update, :destroy]

  # GET /trials
  # GET /trials.json
  def index
    @trials = Trial.all
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

    respond_to do |format|
      if @trial.save
        format.html { redirect_to @trial, notice: 'trial was successfully created.' }
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
        format.html { redirect_to @trial, notice: 'trial was successfully updated.' }
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
      format.html { redirect_to trials_url, notice: 'trial was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trial
    @trial = Trial.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def trial_params
    params.require(:trial).permit(:title)
  end
end
