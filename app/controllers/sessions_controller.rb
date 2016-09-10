class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      if user.activated?
        log_in(user)
        params[:remember_me] == '1' ? remember(user) : forget(user)
        flash[:success] = "Welcome back, #{user.first_name}."
        redirect_to(session[:intended_url] || user)
        session[:intended_url] = nil
      else
       flash.now[:danger] = "Invalid email/password combination!"
        render :new
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
