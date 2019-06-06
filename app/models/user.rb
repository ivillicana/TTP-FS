class User < ApplicationRecord
  has_many :transactions
  has_many :companies, through: :transactions

  has_secure_password

  def portfolio
    portfolio_hash = {}
    self.transactions.each do |t|
      portfolio_hash[t.company.name] ||= Hash.new(0)
      portfolio_hash[t.company.name][:shares] += t.shares_quantity
      portfolio_hash[t.company.name][:value] += (t.shares_quantity * t.price_per_share)
    end
    portfolio_hash
  end
end
