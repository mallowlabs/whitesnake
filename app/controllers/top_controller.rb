class TopController < ApplicationController
  def show
    if logged_in?
      redirect_to user_path
    end
  end
end
