class User < ApplicationRecord
  has_many :transactions
  has_many :companies, through: :transactions

  has_secure_password

  def portfolio
    user_companies = self.companies.uniq.map(&:ticker_symbol).join(",")
    response = Faraday.get("https://api.iextrading.com/1.0/stock/market/batch") do |req|
      req.params['symbols'] = user_companies
      req.params['types'] = 'quote'
    end
      

    portfolio_hash = {}
    self.transactions.each do |t|
      portfolio_hash[t.company.name] ||= Hash.new(0)
      portfolio_hash[t.company.name][:shares] += t.shares_quantity
      portfolio_hash[t.company.name][:value] += (t.shares_quantity * t.price_per_share)
    end
    portfolio_hash
  end

  def portfolio_value
    
  end
end
