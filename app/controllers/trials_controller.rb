# frozen_string_literal: true
# rubocop:disable Metrics/ClassLength
class TrialsController < ApplicationController
  before_action :set_trial, only: %w(show edit update destroy receive_private_key_digest
                                     receive_private_key)
  before_action :set_committee
  skip_before_action :login_required, only: %w(new create show edit update
                                               receive_private_key_digest receive_private_key
                                               clear_permitted_trials)

  # for private key based authentication on trial show
  before_action :set_session_permitted_trials, only: %w(receive_private_key
                                                        receive_private_key_digest
                                                        create)
  before_action :render_private_key_monit, only: [:show, :edit, :update],
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
      if @trial.update(trial_params)
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
    params['private_key_digest'] = Digest::MD5.hexdigest(trial_params[:private_key])
    receive_private_key_digest
  end

  def clear_permitted_trials
    session['permitted_trials'] = []
    redirect_to @committee, notice: t(:your_trial_was_cleared)
  end

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
         environment_id private_key rank_id)
    )
  end

  def trial_exists?
    Trial.exists?(private_key_digest: params[:private_key_digest], id: params[:trial_id])
  end

  def set_session_permitted_trials
    session['permitted_trials'] = [] if session['permitted_trials'].nil?
  end

  def trial_authorized?
    current_user || session['permitted_trials']&.include?(@trial.private_key_digest)
  end

  def render_private_key_monit
    render 'private_key_monit'
  end
end
# rubocop:enable Metrics/ClassLength
