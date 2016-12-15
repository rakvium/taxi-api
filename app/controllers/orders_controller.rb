# class for orders management
class OrdersController < ApplicationController
  before_action :check_client_params, only: [:create]

  def index
    render json: { 'index' => 'index page' }
  end

  # here i should create order from params
  def create
    ord = Order.new(order_params(@client.id))
    if ord.save
      render json: { 'result' => 'Your order was successfully added. Your id: ' + ord.id.to_s }
    else
      render json: { 'error' => ord.errors }
    end
  end

  def update
    order = Order.find(params[:id])
    order.driver_id = Driver.find(2).id # should be current driver
    order.state = 'in progress'
    order.save
    client_email = Client.find(order.client_id).email
    ClientMailer.welcome_email(params[:id], client_email).deliver_now if client_email
  end

  private

  def check_client_params
    @client = Client.current_client(client_params) # id of client in hash
    render json: { 'error' => @client.errors } unless @client.errors.empty?
  end

  def client_params
    params.require(:client).permit(:email, :phone)
  end

  def order_params(client_id)
    parameters = params.require(:order).permit(:from, :to, :comment)
    parameters['client_id'] = client_id
    parameters
  end
end
