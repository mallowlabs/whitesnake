Octokit.configure do |c|
  c.api_endpoint = Settings.github_api_endpoint
  c.web_endpoint = Settings.github_web_endpoint
end
