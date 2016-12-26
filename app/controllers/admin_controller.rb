# admin controller
class AdminController < ApplicationController
  before_action :authenticate_request!
  before_action :current_user_admin

  def index
    render json: Admin.all
  end

  def index_dispatcher
    render json: Dispatcher.all
  end

  def index_driver
    render json: Driver.all
  end

  def index_client
    render json: Client.all
  end

  def create
    admin = Admin.new(params_admin)
    if admin.save
      render json: { name: admin.name, email: admin.email }
    else
      render json: { 'error' => admin.errors }, status: 422
    end
  end

  def create_driver
    driver = Driver.new(params_driver)
    if driver.save
      render json: { name: driver.name, phone: driver.phone, auto: driver.auto }
    else
      render json: { 'error' => driver.errors }, status: 422
    end
  end

  def create_dispatcher
    dispatcher = Dispatcher.new(params_dispatcher)
    if dispatcher.save
      render json: { name: dispatcher.name, email: dispatcher.email }
    else
      render json: { 'error' => dispatcher.errors }, status: 422
    end
  end

  def create_client
    client = Client.new(params_client)
    if client.save
      render json: client
    else
      render json: { 'error' => client.errors }, status: 422
    end
  end

  def show
    render json: Admin.find(params[:id])
  end

  def show_driver
    render json: Driver.find(params[:id])
  end

  def show_dispatcher
    render json: Dispatcher.find(params[:id])
  end

  def show_client
    render json: Client.find(params[:id])
  end

  def update
    admin = Admin.find(params[:id])
    if admin.update_attributes(params_admin)
      render json:  admin
    else
      render json: { 'error' => admin.errors }, status: 422
    end
  end

  def update_driver
    driver = Driver.find(params[:id])
    if driver.update_attributes(params_driver)
      render json: driver
    else
      render json: { 'error' => driver.errors }, status: 422
    end
  end

  def update_dispatcher
    dispatcher = Dispatcher.find(params[:id])
    if dispatcher.update_attributes(params_dispatcher)
      render json: dispatcher
    else
      render json: { 'error' => dispatcher.errors }, status: 422
    end
  end

  def update_client
    client = Client.find(params[:id])
    if client.update_attributes(params_client)
      render json: client
    else
      render json: { 'error' => client.errors }, status: 422
    end
  end

  def destroy
    admin = Admin.find(params[:id])
    if admin.destroy
      render json: { 'The admin is successfully destroyed!' => true }
    else
      render json: { 'error' => admin.errors }, status: 422
    end
  end

  def destroy_driver
    driver = Driver.find(params[:id])
    if driver.destroy
      render json: { 'The driver is successfully destroyed!' => true }
    else
      render json: { 'error' => driver.errors }, status: 422
    end
  end

  def destroy_dispatcher
    dispatcher = Dispatcher.find(params[:id])
    if dispatcher.destroy
      render json: { 'The dispatcher is successfully destroyed!' => true }
    else
      render json: { 'error' => dispatcher.errors }, status: 422
    end
  end

  def destroy_client
    client = Client.find(params[:id])
    if client.destroy
      render json: { 'The client is successfully destroyed!' => client.id }
    else
      render json: { 'error' => client.errors }, status: 422
    end
  end

  private

  def current_user_admin
    return render json: { 'error' => 'You are not a admin' }, status: 422 unless @current_user.instance_of? Admin
  end

  def params_admin
    params.require(:admin).permit(:name, :email, :password, :password_confirmation, :blocked)
  end

  def params_driver
    params.require(:driver).permit(:name, :phone, :password, :auto, :blocked)
  end

  def params_dispatcher
    params.require(:dispatcher).permit(:name, :email, :password, :blocked)
  end

  def params_client
    params.require(:client).permit(:phone, :email)
  end
end
