# class authentication for admins
class AdminAuthenticationController < ApplicationController
  def authenticate_admin
    admin = Admin.find_by(email: params[:email])
    if admin.try(:valid_password?, params[:password])
      render json: payload(admin)
    else
      status = admin ? 'Invalid password' : 'Invalid email'
      render json: { errors: [status] }, status: :unprocessable_entity
    end
  end

  private

  def payload(user)
    return nil unless user && user.id
    {
      auth_token: JsonWebToken.encode(user_id: user.id, type: 'admin'),
      admin: { id: user.id, email: user.email, type: 'admin' }
    }
  end
end
