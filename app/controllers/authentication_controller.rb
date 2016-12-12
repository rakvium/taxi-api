# authenticates users
class AuthenticationController < ApplicationController
  def authenticate_user
    user = Driver.find_by(phone: params[:phone])
    if user.try(:valid_password?, params[:password])
      render json: payload(user)
    else
      render json: { errors: ['Invalid Username/Password'] }, status: :unauthorized
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
