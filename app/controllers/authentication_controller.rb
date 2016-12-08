class AuthenticationController < ApplicationController
  def authenticate_user


    user = Driver.find_by_phone(params[:phone])

    if user.valid_password?(params[:password])
      render json: payload(user)
    # render json: payload(user)
    #else
    #  render json: {errors: ["Invalid Username/Password #{user.id}"]}, status: :unauthorized
    end
  end#permitted = params.require(:user).permit(:name, :age)


  private

  def payload(user)
    return nil unless user and user.id
    {
      auth_token: JsonWebToken.encode({user_id: user.id}),
      driver: {id: user.id, phone: user.phone}
    }
  end
end

