class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    user = where(auth.slice('provider', 'uid')).first || create_from_omniauth(auth)
    user.send :update_credentials, auth['credentials'] if user
    user
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['nickname']
    end
  end

  def each_repository(&block)
    return enum_for(:each_repository) unless block
    octokit_client.repositories(self.name).each(&block)
  end

  private

  def update_credentials(credentials)
    if self.token != credentials['token']
      self.token = credentials['token']
      save!
    end
  end

  def octokit_client
    @octokit_client ||= Octokit::Client.new(oauth_token: self.token)
  end
end
