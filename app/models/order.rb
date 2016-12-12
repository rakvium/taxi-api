# Clients' orders
# Drivers takes them voluntarily
class Order < ApplicationRecord
  belongs_to :client
  belongs_to :driver, optional: true
  validates :from, presence: true
  validates :to, presence: true
  validates :state, presence: true
  validates :price, presence: true, numericality: { greater_than: 0.01 }
end
