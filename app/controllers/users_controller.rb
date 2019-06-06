class UsersController < ApplicationController

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
    redirect_to profile_path, notice: "Welcome #{@user.name}!"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
