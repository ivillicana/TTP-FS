class SessionsController < ApplicationController
  skip_before_action :redirect_if_not_logged_in, only: [:new, :create]
  before_action :redirect_if_logged_in, only: [:new, :create]
  
  def new
  end

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    @user = @user.try(:authenticate, params[:user][:password])
    return redirect_to new_session_path, notice: "Unable to sign in" unless @user

    session[:user_id] = @user.id
    redirect_to dashboard_path(@user), notice: "Welcome #{@user.name}!"
  end

  def destroy
    session.delete :user_id
    redirect_to new_session_path
  end
end
