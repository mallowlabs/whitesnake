Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Settings.github.client_id, Settings.github.client_secret,
    client_options: {
      site: Settings.github_api_endpoint,
      authorize_url: Settings.github_authorize_url,
      token_url: Settings.github_token_url,
    }
end
