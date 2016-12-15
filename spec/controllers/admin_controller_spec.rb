require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  context 'GET #index' do
    it 'should be good' do
      get :index, format: :json
      expect(response).to be_success
    end
  end
end
