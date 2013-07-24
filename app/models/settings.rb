class Settings < Settingslogic
  source Rails.root.join('config/settings.yml')
  namespace Rails.env

  def self.github_web_endpoint
    "https://#{github_web_authority_part}/"
  end

  def self.github_api_endpoint
    github.site
  end

  def self.github_authorize_url
    File.join(github_web_endpoint, "/login/oauth/authorize")
  end

  def self.github_token_url
    File.join(github_web_endpoint, "/login/oauth/access_token")
  end

  def self.github_enterprise?
    URI.parse(github.site).host != 'api.github.com'
  end

  def self.github_web_authority_part
    return 'github.com' unless github_enterprise?
    URI.parse(github.site).select(:host, :port).join(':')
  end

  def self.ci_host
    ci_uri.host
  end

  def self.ci_port
    ci_uri.port
  end

  def self.ci_endpoint_path
    ci_uri.path
  end

  def self.ci_uri
    URI.parse(ci.site)
  end
end
