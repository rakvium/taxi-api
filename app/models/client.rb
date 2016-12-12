# model for clients, this model can makes orders
class Client < ApplicationRecord
  # method creates new client if client with this phone doesn't exist
  def self.current_client(parametrs)
    client = find_by(phone: parametrs[:phone])
    client ||= create(parametrs)
    { 'client_id' => client.id }
  end

  has_many :orders
end
