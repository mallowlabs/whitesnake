class TopController < ApplicationController
  def show
    if logged_in?
      redirect_to profile_path
    end
  end
end
