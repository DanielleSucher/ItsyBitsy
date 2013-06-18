class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  private

    def authenticate
      deny_access if current_user.blank?
    end

    def deny_access
      redirect_to root_path, notice: "Please sign in to access this page."
    end

    def current_user=(user)
      @current_user = user
    end
end
