# class for orders management
class OrdersController < ApplicationController
  before_action :check_client_params, only: [:create]
  before_action :authenticate_request!, only: [:index, :cancel]

  def index
    render json: { 'orders' => @current_user.show_order_list }
  end

  # here i should create order from params
  def create
    ord = Order.new(order_params(@client.id))
    if ord.save
      render json: { 'result' => 'Your order was successfully added. Your id: ' + ord.id.to_s }
    else
      render json: { 'error' => ord.errors }, status: :unprocessable_entity
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

  def cancel
    if @current_user.try(:instance_of?, Driver)
      return render json: { 'error' => "You are not allowed" }, status: 422
    end
    order = Order.find(params[:id])
    order.state = 'canceled'
    order.save
  end

  private

  def check_client_params
    @client = Client.current_client(client_params) # id of client in hash
    render json: { 'error' => @client.errors }, status: :unprocessable_entity unless @client.errors.empty?
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
