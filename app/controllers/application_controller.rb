class ApplicationController < ActionController::Base
  before_action :redirect_if_not_logged_in

  private

  def logged_in?
    !!session[:user_id]
  end

  def redirect_if_not_logged_in
    return redirect_to new_session_path, notice: "You must be logged in" if !logged_in?
  end

  def redirect_if_logged_in
    redirect_to dashboard_path if logged_in?
  end

  def current_user
    @user = User.find_by(id: session[:user_id]) if logged_in?
  end

end
