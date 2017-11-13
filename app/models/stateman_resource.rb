# frozen_string_literal: true
class StatemanResource < ActiveResource::Base
  self.site = Rails.application.secrets.stateman_url
  headers['X-Api-Key'] = Rails.application.secrets.stateman_api_key
end
