module OctokitHelper
  module Controller
    private

    def octokit_client
      @octokit_client ||= current_user &&
        Octokit::Client.new(oauth_token: current_user.token)
    end
  end

  module Model
    private

    def octokit_client
      @octokit_client ||= Octokit::Client.new(oauth_token: self.token)
    end
  end
end
