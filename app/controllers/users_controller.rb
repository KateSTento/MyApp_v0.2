class UsersController < ApplicationController
before_action :require_login, except: [:new, :create]
before_action :require_correct_user, only: [:edit, :update, :destroy]
  def index
    @users = User.all 
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
      if @user.save
        log_in(@user)
        flash[:success] = "Thanks for signing up!"
        redirect_to @user
      else
        render :new
      end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account has been successfully updated!"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    #session[:user_id] = nil
    flash[:success] = "Your account has been successfully deleted!"
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :remember_digest)
    end

    def require_correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = "Unauthorised access!"
        redirect_to root_url
      end
    end
end
