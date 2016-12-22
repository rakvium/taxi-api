# class for orders management
class OrdersController < ApplicationController
  before_action :check_client_params, only: [:create]
  before_action :authenticate_request!, only: [:index, :show, :update, :cancel]

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

  def show
    render json: { 'order' => Order.find(params[:id]) }
  end

  def update
    return render json: { 'error' => 'You are not a driver' }, status: 422 unless @current_user.instance_of? Driver
    order = Order.find(params[:id])
    order.driver_id = @current_user.id
    order.state = 'in progress'
    order.save
    render json: { 'current_order' => order.id }
    send_email_to_client(order.id, order.client_id)
  end

  def cancel
    if @current_user.try(:instance_of?, Driver)
      return render json: { 'error' => 'You are not allowed' }, status: 422
    end
    order = Order.find(params[:id])
    order.state = 'canceled'
    order.save
    render json: { 'current_order' => 'You have canceled order with id ' + order.id.to_s }
  end

  private

  def send_email_to_client(order_id, client_id)
    client_email = Client.find(client_id).email
    ClientMailer.welcome_email(order_id, client_email).deliver_now if client_email
  end

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
