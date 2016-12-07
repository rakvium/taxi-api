class AuthenticationController < ApplicationController
  def authenticate_user
    user = Driver.find_for_database_authentication(phone: params[:phone])
    if user.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  private

  def payload(user)
    return nil unless user and user.id
    {
      auth_token: JsonWebToken.encode({user_id: user.id}),
      user: {id: user.id, phone: user.phone}
    }
  end
end
