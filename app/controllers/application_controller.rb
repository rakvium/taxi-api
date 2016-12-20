# ApplicationController is the only controller that inherits from ActionController::API
# All other controllers in turn inherit from ApplicationController
class ApplicationController < ActionController::API
  attr_reader :current_user

  protected

  def authenticate_request_driver!
    unless driver_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = Driver.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def authenticate_request_admin!
    unless admin_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = Admin.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def authenticate_request_dispatcher!
    unless dispatcher_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = Dispatcher.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  private

  def http_token
    @http_token ||= if request.headers['Authorization'].present?
                      request.headers['Authorization'].split(' ').last
                    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def driver_id_in_token?
    http_token && auth_token && auth_token[:user_id]
  end

  def admin_id_in_token?
    http_token && auth_token && auth_token[:user_id] && auth_token[:type] == 'admin'
  end

  def dispatcher_id_in_token?
    http_token && auth_token && auth_token[:user_id] && auth_token[:type] == 'dispatcher'
  end
end
