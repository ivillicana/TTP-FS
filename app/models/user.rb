class User < ApplicationRecord
  has_many :transactions
  has_many :companies, through: :transactions

  validates :name, :email, :password, presence: true, on: :create
  validates :email, uniqueness: true

  has_secure_password

  def portfolio
    # Create array of user's companies ticker symbols
    user_companies = self.companies.uniq.map(&:ticker_symbol)
    # Make request to IEX API for all user's companies
    response = Faraday.get("https://api.iextrading.com/1.0/stock/market/batch") do |req|
      req.params['symbols'] = user_companies.join(",")
      req.params['types'] = 'quote'
    end
    companies_hash = JSON.parse(response.body)
    #Calculate portfolio values
    portfolio_value(user_companies, companies_hash)
  end

  def portfolio_value(user_companies, companies_hash)
    portfolio_hash = {
      total_value: 0,
      companies: {}
    }
    # Create hash with total amount of shares for each user company
    portfolio_companies = portfolio_hash[:companies]
    self.transactions.each do |t|
      portfolio_companies[t.company.ticker_symbol] ||= Hash.new(0)
      portfolio_companies[t.company.ticker_symbol][:shares] += t.shares_quantity
    end
    # Calculate total value of stock for each user company
    user_companies.each do |comp_symbol|
      latest_price = companies_hash[comp_symbol]["quote"]["latestPrice"]
      shares_quantity =  portfolio_companies[comp_symbol][:shares]
      company_share_value = latest_price * shares_quantity
      portfolio_companies[comp_symbol][:value] = company_share_value
      portfolio_hash[:total_value] += company_share_value
    end
    portfolio_hash
  end
  
end
