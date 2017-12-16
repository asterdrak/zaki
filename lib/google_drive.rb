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

  private

  def service
    @service ||= Google::Apis::DriveV3::DriveService.new
  end
end
