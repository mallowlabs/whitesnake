require 'base64'
require 'octokit_helper'

class JobsController < ApplicationController
  include OctokitHelper::Controller

  before_action :fetch_job_setting, only: [ :create, :destroy ]

  def create
    response = Net::HTTP.start(Settings.ci_host, Settings.ci_port) do |http|
      job_name = job_name(@repository)
      http.post(File.join(Settings.ci_endpoint_path, "/createItem?name=#{CGI.escape job_name}"),
                config_xml(@job_setting, @repository).tap {|x| puts x},
                'Content-Type' => 'text/xml')
    end

    case response
    when Net::HTTPSuccess, Net::HTTPRedirection
      render json: { message: 'OK' }
    else
      render json: { message: "#{response.code} #{response.message}" }, status: response.code
    end
  end

  def destroy
    response = Net::HTTP.start(Settings.ci_host, Settings.ci_port) do |http|
      job_name = job_name(@repository)
      http.post(File.join(Settings.ci_endpoint_path, "/job/#{CGI.escape job_name}/doDelete"), '')
    end
    case response
    when Net::HTTPSuccess, Net::HTTPRedirection
      render json: { message: 'OK' }
    else
      render json: { message: "#{response.code} #{response.message}" }, status: response.code
    end
  end

  private

  def fetch_job_setting
    @repository = octokit_client.repository(params[:repository_id])
    response = octokit_client.content(params[:repository_id], path: '.whitesnake.yml')
    if response[:type] == 'file'
      case response[:encoding]
      when 'base64'
        content = Base64.decode64(response[:content])
      else
        content = response[:content]
      end
      @job_setting = Psych.load(content)
    end
    @job_setting = default_job_setting(@repository).update(@job_setting || {})
  rescue => error
    p error
    render json: { message: error.message }, status: 404
  end

  def default_job_setting(repository)
    {
      'branches' => %w[origin/master],
      'rbenv'    => %w[system],
      'script'   => %w[bundle && bundle exec rake spec],
    }
  end

  def job_name(repository)
    view_context.job_name(repository)
  end

  def config_xml(job_setting, repository)
    render_to_string 'jobs/config', layout: false, locals: { job_setting: job_setting, repository: repository }
  end
end
