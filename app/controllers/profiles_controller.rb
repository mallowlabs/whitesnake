require 'json'

class ProfilesController < ApplicationController
  before_action :require_login

  def show
    @jobs = Net::HTTP.start('localhost', 8080) do |http|
      response = http.get("/api/json?tree=jobs[name,url]")
      data = JSON.load(response.body)
      data['jobs'].inject({}) do |hash, job|
        hash.update(job['name'] => job)
      end
    end
  end
end
