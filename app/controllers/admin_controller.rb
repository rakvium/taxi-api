# admin controller
class AdminController < ApplicationController
  before_action :authenticate_request_admin!

  def index
    render json: { 'logged_in' => true }
  end
end
