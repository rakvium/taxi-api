class Order < ApplicationRecord
  validates :from, presence: true
  validates :to, presence: true
  validates :state, presence: true
  # comment cause we need a price generator.
  # validates :price, presence: true, numericality: { greater_than: 0.01 }
  belongs_to :client
  belongs_to :driver, optional: true
end
