class UsersController < ApplicationController
  skip_before_action :redirect_if_not_logged_in, only: [:new, :create]
  before_action :redirect_if_logged_in, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.errors.any?
      flash[:notice] = @user.errors.full_messages.join(", ")
      return render :new
    end
    session[:user_id] = @user.id
    redirect_to dashboard_path, notice: "Welcome #{@user.name}!"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
