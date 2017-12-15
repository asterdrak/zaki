# frozen_string_literal: true
require 'omniauth-oauth2'
module OmniAuth
  module Strategies
    class Sso < OmniAuth::Strategies::OAuth2
      CUSTOM_PROVIDER_URL = Rails.application.secrets.sso_provider_url

      option :client_options, site: CUSTOM_PROVIDER_URL,
                              authorize_url: "#{CUSTOM_PROVIDER_URL}/auth/sso/authorize",
                              access_token_url: "#{CUSTOM_PROVIDER_URL}/auth/sso/access_token"

      uid do
        raw_info['id']
      end

      info do
        {
          email: raw_info['info']['email']
        }
      end

      extra do
        {
          is_admin: raw_info['is_admin'],
          first_name: raw_info['extra']['first_name'],
          last_name: raw_info['extra']['last_name']
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/auth/sso/user.json?oauth_token=#{access_token.token}")
                                  .parsed
      end
    end
  end
end
