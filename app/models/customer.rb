class Customer < ApplicationRecord
  validates :name,presence: true
  validates :name,presence: true

  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  validates :email, uniqueness: true

  has_many :orders
  has_many :tickets, through: :orders

end
