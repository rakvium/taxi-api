class Dispatcher < ApplicationRecord
  validates :name, presence: true
  validetes :emila, presence: true
  validetes :password, presence: true
end
