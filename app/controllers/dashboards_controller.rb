class DashboardsController < ApplicationController

  def show
    @user = current_user
    @companies = @user.companies
  end

  def transactions
    @user = current_user
    @transactions = @user.transactions
  end

end