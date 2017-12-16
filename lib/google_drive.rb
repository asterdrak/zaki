# frozen_string_literal: true
class GoogleDrive < GoogleAbstract
  def initialize(committee)
    super
    service.client_options.application_name = APPLICATION_NAME
  end

  def authorized
    service.authorization = authorize
    self
  end

  def find_by_name(name)
    service.list_files(q: "name contains '#{name}'")
  end

  def find_folders_by_name(name)
    service.list_files(q: "name contains '#{name}' and mimeType contains 'folder'")
  end

  def find_in_folder(name)
    service.list_files(q: "parents in '#{name}'")
  end

  def upload_file(folder_id:, upload_source:, file_name:)
    file_metadata = {
      name: file_name,
      parents: [folder_id]
    }
    service.create_file(file_metadata, fields: 'id', upload_source: upload_source)
  end

  def create_folder(name)
    file_metadata = {
      name: name,
      parents: [committee.drive_root],
      mime_type: 'application/vnd.google-apps.folder'
    }
    service.create_file(file_metadata, fields: 'id')
  end

  # private

  def service
    @service ||= Google::Apis::DriveV3::DriveService.new
  end
end
