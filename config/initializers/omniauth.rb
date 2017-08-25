# Change this omniauth configuration to point to your registered provider
# Since this is a registered application, add the app id and secret here
APP_ID = Rails.application.secrets.sso_app_id
APP_SECRET = Rails.application.secrets.sso_app_secret

CUSTOM_PROVIDER_URL = Rails.application.secrets.sso_provider_url

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :sso, APP_ID, APP_SECRET
end
