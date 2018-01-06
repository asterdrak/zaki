# frozen_string_literal: true
module TrialCommentizer
  def comment_update_action
    return if @trial.created?
    @role = 'public'
    comments.create(comment: t('history.trial_edited',
                               who: current_user&.email || t(:candidate)), title: 'history')
  end

  def comment_set_state_action
    @role = 'public'
    comments.create(comment: t('history.state_changed',
                               who: current_user.email, from: @old_state_name,
                               to: @trial.stateman_trial.state.name), title: 'history')
  end

  def comment_upload_action
    @role = 'public'
    comments.create(comment: t('history.file_uploaded', title: trial_params[:name],
                                                        who: current_user&.email || t(:candidate)),
                    title: 'history')
  end

  def comment_delete_versions_action
    @role = 'public'
    comments.create(comment: t('history.versions_dismissed', who: current_user&.email),
                    title: 'history')
  end
end
