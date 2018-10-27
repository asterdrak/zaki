# frozen_string_literal: true

require 'google_drive'

class CommitteesController < ApplicationController
  prepend_before_action :set_committee, only: [:show, :edit, :update, :destroy]
  skip_before_action :login_required, only: :show

  # GET /committees
  # GET /committees.json
  def index
    @committees = policy_scope(Committee)
    redirect_to @committees.first if @committees.one?
  end

  # GET /committees/1
  # GET /committees/1.json
  def show
    @state_trial_count = StatemanTrial.get(:summary,
                                           organization_id: @committee.stateman.organization_id,
                                           id: 'trials')
  end

  # GET /committees/new
  def new
    @committee = Committee.new
  end

  # GET /committees/1/edit
  def edit
    set_edit_instance_variables
    @drive = GoogleDrive.new(@committee)
  end

  # POST /committees
  # POST /committees.json
  def create
    @committee = Committee.new(committee_params)

    respond_to do |format|
      if @committee.save
        format.html { redirect_to @committee, notice: t(:committee_successfully_created) }
        format.json { render :show, status: :created, location: @committee }
      else
        format.html { render :new }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /committees/1
  # PATCH/PUT /committees/1.json
  def update
    set_edit_instance_variables
    respond_to do |format|
      if @committee.update(committee_params)
        format.html { redirect_to @committee, notice: t(:committee_successfully_updated) }
        format.json { render :show, status: :ok, location: @committee }
      else
        format.html { render :edit }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /committees/1
  # DELETE /committees/1.json
  def destroy
    @committee.destroy
    respond_to do |format|
      format.html { redirect_to committees_url, notice: t(:committee_successfully_destroyed) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_committee
    @committee = Committee.find(params[:id])
  end

  def authorize_committee
    authorize @committee || Committee
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def committee_params
    params.require(:committee).permit(:name, :overdue_state_id, :positive_finish_state_id,
                                      :negative_finish_state_id, :min_trial_tasks_count,
                                      :drive_token_raw, :drive_root, :formal_conditions, :info)
  end

  def set_edit_instance_variables
    @states = @committee.stateman.organization.stateman_states
    @ranks = @committee.ranks
    @rank = Rank.new
    @environment = Environment.new
    @environments = @committee.environments
  end
end
