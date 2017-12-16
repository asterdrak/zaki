# frozen_string_literal: true
require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

class GoogleAbstract
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
  APPLICATION_NAME = 'ModOrg - ZakiApp'
  SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_METADATA_READONLY

  attr_accessor :committee

  def initialize(committee)
    @committee = committee
  end

  def authorize(code = nil)
    return credentials unless credentials.nil?
    raise ArgumentError if code.nil?
    authorizer.get_and_store_credentials_from_code(
      user_id: committee_id, code: code, base_url: OOB_URI
    )
  end

  def authorization_url
    authorizer.get_authorization_url(base_url: OOB_URI)
  end

  private

  def committee_id
    @committee.id
  end

  def client_id
    @client_id ||= Google::Auth::ClientId.from_hash(
      MultiJson.load(Rails.application.secrets.google_client_id)
    )
  end

  def token_store
    @token_store ||= DbTokenStore.new(Committee)
  end

  def authorizer
    @authorizer ||= Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
  end

  def credentials
    @credentials ||= authorizer.get_credentials(committee_id)
  end
end
