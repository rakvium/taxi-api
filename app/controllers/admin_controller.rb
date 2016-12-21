# admin controller
class AdminController < ApplicationController
  before_action :authenticate_request!

  def index
    render json: { 'logged_in' => true }
  end

  def create_admin
    admin = Admin.new(params_admin)
    if admin.save
      render json: { name: admin.name, email: admin.email }
    else
      render json: { 'error' => admin.errors }
    end
  end

  def create_driver
    driver = Driver.new(params_driver)
    if driver.save
      render json: { name: driver.name, phone: driver.phone, auto: driver.auto }
    else
      render json: { 'error' => driver.errors }
    end
  end

  def create_dispatcher
    dispatcher = Dispatcher.new(params_dispatcher)
    if dispatcher.save
      render json: { name: dispatcher.name, email: dispatcher.email }
    else
      render json: { 'error' => dispatcher.errors }
    end
  end

  private

  def params_admin
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end

  def params_driver
    params.require(:driver).permit(:name, :phone, :password, :auto)
  end

  def params_dispatcher
    params.require(:dispatcher).permit(:name, :email, :password)
  end
end
