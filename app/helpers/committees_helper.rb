# frozen_string_literal: true
module CommitteesHelper
  def folders
    @drive.authorized.find_folders_by_name(params[:drive_root]).files.collect { |f| [f.name, f.id] }
  end
end
