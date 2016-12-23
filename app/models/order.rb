# Clients' orders
# Drivers takes them voluntarily
class Order < ApplicationRecord
  belongs_to :client
  belongs_to :driver, optional: true
  validates :from, presence: true
  validates :to, presence: true
  validates :state, presence: true
  # comment cause we need a price generator.
  # validates :price, presence: true, numericality: { greater_than: 0.01 }
  before_save do |order|
    order.price = (order.from + order.to).chars.map(&:ord).inject(:+) % 500
  end
end
