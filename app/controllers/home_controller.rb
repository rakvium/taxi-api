# Driver page
class HomeController < ApplicationController
  before_action :authenticate_request_driver!

  def index
    render json: { 'logged_in' => true }
  end
end
