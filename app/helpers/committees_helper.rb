# frozen_string_literal: true
module CommitteesHelper
  def folders
    @drive.authorized.find_folders_by_name(params[:drive_root]).files.collect { |f| [f.name, f.id] }
  end

  def stateman_url(commitee)
    Rails.application.secrets.stateman_url + '/organizations/' + commitee.stateman.organization_id
  end

  def formal_condition_value
    return nil if @committee.formal_conditions.blank?
    @committee.formal_conditions.lines.each(&:squish!).join("\n")
  end
end
