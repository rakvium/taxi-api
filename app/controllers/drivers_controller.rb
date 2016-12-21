# Drivers controller
class DriversController < ApplicationController
  def index
    # render json: { 'orders' => Order.where(state: 'active') }
  end

  # for auth driver. Instead of new controller
  def create
    driver = Driver.find_by(phone: params[:phone])
    if driver.try(:valid_password?, params[:password])
      render json: payload(driver)
    else
      status = driver ? 'Invalid password' : 'Invalid phone'
      render json: { errors: [status] }, status: :unprocessable_entity
    end
  end

  private

  def payload(user)
    return nil unless user && user.id
    {
      auth_token: JsonWebToken.encode(user_id: user.id, type: 'Driver'),
      driver: { id: user.id, phone: user.phone, type: 'Driver' }
    }
  end
end
