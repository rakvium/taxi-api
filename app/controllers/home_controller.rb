# being used for a manual authentication test
# TODO: write automatic test to test authentication
class HomeController < ApplicationController

  before_action :authenticate_request_driver!
  before_action :authenticate_request_admin!


  def index
    render json: { 'logged_in' => true }
  end
end
