require 'pry'
class TransactionsController < ApplicationController

  def create
    binding.pry
  end

  private

  def transaction_params
    params.permit(:ticker_symbol, :shares_quantity)
  end
end