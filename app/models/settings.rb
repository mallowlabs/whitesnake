class Settings < Settingslogic
  source Rails.root.join('config/settings.yml')
  namespace Rails.env

  def self.github_api_endpoint
    "https://#{github.host}/api/v3"
  end

  def self.github_authorize_url
    "https://#{github.host}/login/oauth/authorize"
  end

  def self.github_token_url
    "https://#{github.host}/login/oauth/access_token"
  end
end
