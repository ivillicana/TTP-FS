class User < ApplicationRecord
  has_many :transactions
  has_many :users, through: :transactions

  has_secure_password
end
