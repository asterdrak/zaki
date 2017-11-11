# frozen_string_literal: true
module TrialsHelper
  def stateman_trial(trial, stateman_trials)
    stateman_trials.find { |st| st.id == trial.stateman_trial_id.to_i }
  end

  def style_for_trial_badge(trial, stateman_trials = nil)
    if stateman_trials.nil?
      'background-color: #' + trial.stateman_trial.state.color
    else
      'background-color: #' + stateman_trial(trial, stateman_trials).state.color
    end
  end
end
