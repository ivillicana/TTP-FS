require 'pry'
class TransactionsController < ApplicationController

  def create
    ticker = transaction_params[:ticker_symbol]
    quantity = transaction_params[:shares_quantity].to_f

    # redirect back to dashboard if quantity is not whole or <= 0
    return redirect_to dashboard_path, notice: "Please enter valid values" if !validate_quantity(quantity)

    response = Faraday.get("https://api.iextrading.com/1.0/stock/#{ticker}/quote")
    if response.success?
      company_hash = JSON.parse(response.body)
      flash[:notice] = Transaction.attempt_transaction(company_hash, current_user, quantity)
    else
      flash[:notice] = "Please enter valid values"
    end
    redirect_to dashboard_path
  end

  def display_stock
    @company = Company.find_by(ticker_symbol: params[:name])
  end

  def sell_stock
    user = current_user
    company = Company.find_by(ticker_symbol: params.permit(:name)[:name])
    ticker = transaction_params[:ticker_symbol]
    quantity = transaction_params[:shares_quantity].to_f

    response = Faraday.get("https://api.iextrading.com/1.0/stock/#{ticker}/quote")
    if response.success?
      company_hash = JSON.parse(response.body)
      flash[:notice] = Transaction.attempt_sell(company_hash, current_user, quantity)
    else
      flash[:notice] = "Please enter valid values"
    end
    redirect_to dashboard_path
  end

  private

  def transaction_params
    params.permit(:ticker_symbol, :shares_quantity)
  end

  def validate_quantity(quantity)
    quantity % 1 == 0 && quantity > 0 ? true : false
  end
end