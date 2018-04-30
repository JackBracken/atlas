Rails.application.config.middleware.use OmniAuth::Builder do
  provider :strava, Rails.application.secrets.strava_client_id, Rails.application.secrets.strava_api_key, scope: 'view_private'
end

OmniAuth.config.logger = Rails.logger

OmniAuth.config.on_failure = proc { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

# https://www.strava.com/oauth/authorize?approval_prompt=auto&client_id=24dd619015ca42d61372570153091c5f775bda45&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fauth%2Fstrava%2Fcallback&response_type=code&scope=view_private&state=b4a0a9a8d53967cfc03b4753a99478aa41a1d2832e080ba7
