class OrderController < ApplicationController
  def index
    render json: { 'index' => 'index page' }
  end

  # here i should create order from params
  def add_order
    client = Client.current_client(client_params) # id of client in hash
    ord = Order.new(client.merge(order_params))
    if ord.save
      render json: { 'result' => 'Your order was successfully added. Your id: ' + ord.id.to_s }
    else
      render json: { 'error' => ord.errors }
    end
  end

  private

  def client_params
    params.require(:client).permit(:email, :phone)
  end

  def order_params
    params.require(:order).permit(:from, :to, :comment)
  end
end
