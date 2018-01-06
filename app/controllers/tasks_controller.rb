# frozen_string_literal: true
class TasksController < ApplicationController
  include TrialAuthorizer, TrialCommentizer
  before_action :set_task, only: [:update, :destroy, :edit]
  before_action :set_committee, :set_trial

  skip_before_action :login_required, except: [:destroy]
  before_action :render_private_key_monit, except: [:destroy],
                                           unless: :trial_authorized?

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @trial.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        comment_task_create_action
        format.html { redirect_to [@committee, @trial], notice: t(:task_successfully_created) }
      else
        format.html do
          redirect_to [@committee, @trial],
                      alert: @task.errors.full_messages.to_sentence
        end
      end
    end
  end

  # GET /tasks/1/edit
  def edit; end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        comment_task_update_action
        format.html { redirect_to [@committee, @trial], notice: t(:task_successfully_updated) }
      else
        format.html do
          redirect_to [@committee, @trial],
                      alert: @task.errors.full_messages.to_sentence
        end
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      comment_task_destroy_action
      format.html { redirect_to [@committee, @trial], notice: t(:task_successfully_destroyed) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  def set_committee
    @committee = Committee.find(params[:committee_id])
  end

  def set_trial
    @trial = @committee.trials.find(params[:trial_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:number, :content, :deadline)
  end
end
