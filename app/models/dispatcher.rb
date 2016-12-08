# model for dispatcher, this model create and edit orders
class Dispatcher < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
