# ApplicationController is the only controller that inherits from ActionController::API
# All other controllers in turn inherit from ApplicationController
class ApplicationController < ActionController::API
  attr_reader :current_user

  protected

  def authenticate_request!
    if http_token && auth_token && auth_token[:type] && auth_token[:user_id]
      authenticate(auth_token[:type].constantize)
    else
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end
  end

  private

  def authenticate(user)
    @current_user = user.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def http_token
    @http_token ||= if request.headers['Authorization'].present?
                      request.headers['Authorization'].split(' ').last
                    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end
end
