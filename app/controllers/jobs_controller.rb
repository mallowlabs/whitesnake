class JobsController < ApplicationController
  def create
    repository = current_user.repository(params[:repository_id])
    @response = Net::HTTP.start('localhost', 8080) do |http|
      http.post("/createItem?name=#{CGI.escape params[:repository_id]}",
                config_xml(repository),
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
    response = Net::HTTP.start('localhost', 8080) do |http|
      http.post("/job/#{CGI.escape params[:repository_id]}/doDelete", '')
    end
    case response
    when Net::HTTPSuccess, Net::HTTPRedirection
      render json: { message: 'OK' }
    else
      render json: { message: "#{response.code} #{response.message}" }, status: response.code
    end
  end

  private

  def config_xml(repository)
    render_to_string 'jobs/config', layout: false, locals: { repository: repository }
  end
end
