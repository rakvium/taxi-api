# Model for clients, this model can makes orders
class Client < ApplicationRecord
  has_many :orders

  validates :phone, presence: true, length: { is: 10 },
                    numericality: { only_integer: true }
  validates :email, email: true

  # method creates new client if client with this phone doesn't exist
  def self.current_client(params)
    client = find_or_initialize_by(phone: params[:phone])
    client.email = params[:email]
    client.save
    client
  end
end
