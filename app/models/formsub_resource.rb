# frozen_string_literal: true
class FormsubResource < ActiveResource::Base
  self.site = Rails.application.secrets.formsub_url
  headers['X-Api-Key'] = Rails.application.secrets.formsub_api_key
end
