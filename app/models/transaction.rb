class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :company

  def self.attempt_transaction(company_hash, user, quantity)
    transaction_price = (company_hash["latestPrice"] * quantity)
    return "Not enough cash" if user.balance < transaction_price || quantity <= 0

    company = Company.find_or_create_by(ticker_symbol: company_hash["symbol"], name: company_hash["companyName"])
    transaction_hash = {
      user: user,
      company: company,
      shares_quantity: quantity,
      price_per_share: company_hash["latestPrice"],
      status: "complete"
    }
    user.balance -= transaction_price
    user.save
    Transaction.create(transaction_hash)
    "Transaction Successful"
  end

  def self.attempt_sell(company_hash, user, quantity)
    transaction_price = (company_hash["latestPrice"] * quantity)
    company = Company.find_or_create_by(ticker_symbol: company_hash["symbol"], name: company_hash["companyName"])
    transaction_hash = {
      user: user,
      company: company,
      shares_quantity: -quantity,
      price_per_share: -company_hash["latestPrice"],
      status: "complete"
    }
    user.balance += transaction_price
    user.save
    Transaction.create(transaction_hash)
    "Transaction Successful"
  end

end
