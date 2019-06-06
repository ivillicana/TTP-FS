class User < ApplicationRecord
  has_many :transactions
  has_many :companies, through: :transactions

  has_secure_password
end
