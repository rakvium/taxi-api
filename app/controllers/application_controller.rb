class ApplicationController < ActionController::API
   before_filter :configure_permitted_parameters, if: :devise_controller?

   attr_reader :current_user

    protected
    def authenticate_request!
      unless user_id_in_token?
        render json: { errors: ['Not Authenticated'] }, status: :unauthorized
        return
      end
      @current_user = Driver.find(auth_token[:user_id])
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
      http_token && auth_token && auth_token[:user_id].to_i
    end

    protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :phone, :password, :auto, :status])
      end
end
