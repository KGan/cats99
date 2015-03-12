class SessionsController < ApplicationController
  before_action :require_login, only: [:new, :create]
  def create
    @user = User.find_by_credentials(*session_params.values)
    if @user
      login_user!
      redirect_to cats_url
    else
      flash.now[:errors] = "User not found"
      render :new
    end

  end

  def new
    render :new
  end
  #log out current user
  def destroy
    sess = current_user.sessions.find_by(session_token: session[:session_token])
    session[:session_token] = nil
    if sess
      sess.destroy
      redirect_to cats_url
    else
      redirect_to new_session_url
    end
  end

  def log_out_all
    current_user.sessions.each do |session|
      session.destroy unless session.session_token == session[:session_token]
    end
    redirect_to :back
  end

  def log_out_remote
    p params[:id]
    sess = current_user.sessions.find(params[:id])
    if sess
      sess.destroy
    else
      flash[:error] = "No session"
    end
    redirect_to :back
  end

  private
    def require_login
      if logged_in?
        redirect_to cats_url
      end
    end

    def session_params
      params.require(:user).permit(:user_name, :password)
    end
end
