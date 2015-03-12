class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= Session.find_by(:session_token => session[:session_token]).try(:user)
  end

  def logged_in?
    current_user != nil
  end

  def login_user!
    ip = request.remote_ip
    user_agent = request.env["HTTP_USER_AGENT"]
    sess = Session.create(user_id: @user.id, environment: user_agent, location: ip)
    session[:session_token] = sess.session_token
  end

  private

end
