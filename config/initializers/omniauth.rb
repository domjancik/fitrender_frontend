Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :fitcvut_oauth2, Rails.application.secrets.fit_auth_id, Rails.application.secrets.fit_auth_secret
end
