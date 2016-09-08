class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
    def require_login
      unless current_user
        session[:intended_url] = request.url
        flash[:warning] = "Please sign in first!"
        redirect_to new_session_url
      end
    end

    def current_user?(user)
      current_user == user
    end

    helper_method :current_user?
end
