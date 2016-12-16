# ApplicationController is the only controller that inherits from ActionController::API
# All other controllers in turn inherit from ApplicationController
class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :configure_permitted_parameters_admin, if: :devise_controller?

  attr_reader :current_user

  protected

  def authenticate_request_driver!
    unless user_id_in_token? # && auth_token[:type] == 'driver'
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = Driver.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def authenticate_request_admin!
    unless admin_id_in_token? && auth_token[:type] == 'admin'
      render json: { errors: ['Nqot Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = Admin.find(auth_token[:user_id])
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

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id]
  end

  def admin_id_in_token?
    http_token && auth_token && auth_token[:user_id]
  end

  def configure_permitted_parameters
    added_attrs = [:name, :phone, :password, :auto, :status]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def configure_permitted_parameters_admin
    added_attrs = [:name, :email, :password]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
