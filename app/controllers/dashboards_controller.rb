class DashboardsController < ApplicationController

  def show
    @user = current_user
    @portfolio = @user.portfolio
  end

  def transactions
    @user = current_user
    @transactions = @user.transactions
  end

end