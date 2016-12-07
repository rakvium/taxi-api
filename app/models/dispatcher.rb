# class Dispatcher
class Dispatcher < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
