# Driver authenticates
class AuthenticationController < ApplicationController
  def authenticate_driver
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
      auth_token: JsonWebToken.encode(user_id: user.id),
      driver: { id: user.id, phone: user.phone }
    }
  end
end
