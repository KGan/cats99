class UsersController < ApplicationController
  before_action :require_login
  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!
      redirect_to cats_url
    else
      render :new
    end
  end


private
  def require_login
    if logged_in?
      redirect_to cats_url
    end
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
