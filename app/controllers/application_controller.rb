class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Octokit::Error do |exception|
    Rails.logger.error "#{exception.class}: #{exception.message}"
    redirect_to logout_path
  end

  private

  def require_login
    return if current_user
    redirect_to root_path
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    not current_user.nil?
  end
  helper_method :logged_in?
end
