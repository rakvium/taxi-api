# Model for clients, this model can makes orders
class Client < ApplicationRecord
  has_many :orders

  # method creates new client if client with this phone doesn't exist
  def self.current_client(params)
    client = find_or_initialize_by(phone: params[:phone])
    client.email = params[:email]
    client.save
    { 'client_id' => client.id }
  end
end
