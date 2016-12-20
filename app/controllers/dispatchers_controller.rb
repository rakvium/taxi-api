# Dispatcher controller
class DispatchersController < ApplicationController
  before_action :authenticate_request_dispatcher!, only: [:index]

  def index
    render json: { 'orders' => Order.where(state: 'in progress') }
  end

  # for auth dispatcher. Instead of new controller
  def create
    dispatcher = Dispatcher.find_by(email: params[:email])
    if dispatcher.try(:valid_password?, params[:password])
      render json: payload(dispatcher)
    else
      status = dispatcher ? 'Invalid password' : 'Invalid email'
      render json: { errors: [status] }, status: :unprocessable_entity
    end
  end

  private

  def payload(user)
    return nil unless user && user.id
    {
      auth_token: JsonWebToken.encode(user_id: user.id, type: 'dispatcher'),
      dispatcher: { id: user.id, email: user.email, type: 'dispatcher' }
    }
  end
end
