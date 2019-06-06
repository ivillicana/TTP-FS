# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(name: "John Doe", email: "test@testemail.com", password: "Password1")

companies = [
  {
    ticker_symbol: "AAPL",
    name: "Apple Inc."
  },
  {
    ticker_symbol: "GOOG",
    name: "Alphabet Inc."
  },
  {
    ticker_symbol: "MSFT",
    name: "Microsoft"
  },
  {
    ticker_symbol: "INTC",
    name: "Intel"
  }
]
transactions = [
  {
    shares_quantity: 100,
    price_per_share: 350.50,
    status: "complete",
    user: user
  },
  {
    shares_quantity: 25,
    price_per_share: 882,
    status: "complete",
    user: user
  },
  {
    shares_quantity: 750,
    price_per_share: 25.75,
    status: "complete",
    user: user
  },
  {
    shares_quantity: 200,
    price_per_share: 50.35,
    status: "complete",
    user: user
  }
]

companies.each_with_index do |comp_hash, idx|
  company = Company.create(comp_hash)
  company.transactions.create(transactions[idx])
end

user.transactions.create({
  shares_quantity: 78,
  price_per_share: 134.87,
  status: "complete",
  company: Company.first
})

