class Order < ApplicationRecord
  belongs_to :client
  belongs_to :driver
  validates :from, presence: true
  validates :to, presence: true
  validates :state, presence: true
  validates :price, presence: true, numericality: { greater_than: 0.01 }
end