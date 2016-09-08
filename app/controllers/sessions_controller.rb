class SessionsController < ApplicationController

  def new
    
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      log_in(user)
      flash[:success] = "Welcome back, #{user.first_name}."
      redirect_to user
    else
      flash.now[:danger] = "Invalid email/password combination!"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
