# frozen_string_literal: true
# rubocop:disable Metrics/ClassLength

require 'google_drive'

class TrialsController < ApplicationController
  include TrialAuthorizer
  before_action :set_trial, only: %w(show edit update destroy upload receive_private_key_digest
                                     receive_private_key versions)
  before_action :set_committee
  skip_before_action :login_required, only: %w(new create show edit update
                                               receive_private_key_digest receive_private_key
                                               clear_permitted_trials upload)

  # for private key based authentication on trial show
  before_action :set_session_permitted_trials, only: %w(receive_private_key
                                                        receive_private_key_digest
                                                        create)
  before_action :render_private_key_monit, only: [:show, :edit, :update, :upload],
                                           unless: :trial_authorized?

  # GET /trials
  # GET /trials.json
  def index
    @trials = @committee.trials.includes(:rank, :environment)
    @stateman_trials = @committee.stateman.organization.stateman_trials
  end

  # GET /trials/1
  # GET /trials/1.json
  def show
    @trial.deadline_overdue
    @tasks = @trial.tasks
    @task = Task.new
    respond_to do |format|
      format.pdf do
        response.set_header('Content-type', 'application/octet-stream') if params[:download]
        @filename = "#{@trial.title}.pdf"
      end
      format.html
    end
  end

  # GET /trials/new
  def new
    @trial = Trial.new
  end

  # GET /trials/1/edit
  def edit; end

  # POST /trials
  # POST /trials.json
  # rubocop:disable Metrics/MethodLength
  def create
    @trial = Trial.new(trial_params)
    @trial.committee = @committee
    respond_to do |format|
      if @trial.save
        session['permitted_trials'] = session['permitted_trials'] | [@trial.private_key_digest]

        format.html do
          if current_user.present?
            redirect_to @trial.referer || [@committee, @trial],
                        notice: t(:trial_successfully_created)
          else
            redirect_to @trial.referer || committee_trial_authorize_path(@committee, @trial,
                                                                         @trial.private_key_digest),
                        notice: t(:trial_successfully_created)
          end
        end
        format.json { render :show, status: :created, location: @trial }
      else
        format.html { render :new }
        format.json { render json: @trial.errors, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  # PATCH/PUT /trials/1
  # PATCH/PUT /trials/1.json
  def update
    respond_to do |format|
      if @trial.update_safe(trial_params)
        format.html do
          redirect_to @trial.referer || [@committee, @trial],
                      notice: t(:trial_successfully_updated)
        end
        format.json { render :show, status: :ok, location: @trial }
      else
        format.html { render :edit }
        format.json { render json: @trial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trials/1
  # PATCH/PUT /trials/1.json
  def set_state
    trial = Trial.find(params[:trial_id])
    retval = trial.set_state_id(params[:state_id])

    respond_to do |format|
      if retval
        format.html { redirect_to [@committee, trial], notice: t(:state_was_successfully_updated) }
        format.json { head :ok }
      else
        format.html { redirect_to [@committee, trial], notice: t(:state_couldnt_be_updated) }
        format.json { head :unprocessable_entity }
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
                    notice: t(:trial_successfully_destroyed)
      end
      format.json { head :no_content }
    end
  end

  def receive_private_key_digest
    if trial_exists?
      session['permitted_trials'] = session['permitted_trials'] | [params[:private_key_digest]]
      redirect_to [@committee, @trial]
    else
      @trial.errors.add(:private_key, t(:must_be_correct))
      render 'private_key_monit'
    end
  end

  def receive_private_key
    if trial_params[:private_key].length == 32
      params['private_key_digest'] = trial_params[:private_key]
    else
      params['private_key_digest'] = Digest::MD5.hexdigest(trial_params[:private_key])
    end
    receive_private_key_digest
  end

  def clear_permitted_trials
    session['permitted_trials'] = []
    redirect_to @committee, notice: t(:your_trial_was_cleared)
  end

  def upload
    path = 'tmp/' + trial_params[:attachment].original_filename
    File.open(path, 'wb') do |file|
      file.write(trial_params[:attachment].read)
    end
    @committee.drive.authorized.upload_file(folder_id: @trial.drive_folder, upload_source: path,
                                            file_name: Time.zone.now.strftime('%Y%d%m%H%M%S') +
      " - #{trial_params[:name]} - " + trial_params[:attachment].original_filename)
    redirect_to [@committee, @trial], notice: t(:file_sent)
  end

  def versions; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trial
    @trial = Trial.find(params[:id] || params[:trial_id])
  end

  def set_committee
    @committee = Committee.find(params[:committee_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def trial_params
    params.require(:trial).permit(
      %w(title deadline status referer email phone_number supervisor
         environment_id private_key rank_id attachment name drive_folder)
    )
  end

  def trial_exists?
    Trial.exists?(private_key_digest: params[:private_key_digest], id: params[:trial_id])
  end
end
# rubocop:enable Metrics/ClassLength
