require 'pry'
class TransactionsController < ApplicationController

  def create
    ticker = transaction_params[:ticker_symbol]
    quantity = transaction_params[:shares_quantity].to_f
    return redirect_to dashboard_path, notice: "Please enter valid values" if !validate_quantity(quantity)

    response = Faraday.get("https://api.iextrading.com/1.0/stock/#{ticker}/quote")
    if response.success?
      company_hash = JSON.parse(response.body)
      Transaction.attempt_transaction(company_hash, current_user, quantity)
      flash[:notice] = "Successful Transaction"
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