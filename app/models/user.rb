require 'octokit_helper'

class User < ActiveRecord::Base
  include OctokitHelper::Model

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
    octokit_client.repositories(nil, type: 'owner').each(&block)
  end

  def repository(name)
    octokit_client.repository(owner: self.name, repo: name)
  end

  private

  def update_credentials(credentials)
    if self.token != credentials['token']
      self.token = credentials['token']
      save!
    end
  end
end
