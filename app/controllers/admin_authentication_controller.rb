# class authentication for admins
class AdminAuthenticationController < ApplicationController
  def authenticate_admin
    admin = Admin.find_by(email: params[:email])
    if admin.try(:valid_password?, params[:password])
      render json: payload(admin)
    else
      render json: { errors: ['Invalid Username/Password'] }, status: :unauthorized
    end
  end

  private

  def payload(user)
    return nil unless user && user.id
    {
      auth_token: JsonWebToken.encode(user_id: user.id),
      admin: { id: user.id, email: user.email }
    }
  end
end
