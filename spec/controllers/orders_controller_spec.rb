require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  context 'GET #index' do
    it 'should be good' do
      get :index, format: :json
      expect(response).to be_success
    end
  end

  context 'POST #create' do
    it 'when all parameters is good' do
      expect do
        post :create, order: FactoryGirl.attributes_for(:order),
                      client: FactoryGirl.attributes_for(:client)
      end.to change(Order, :count).by(1)
    end
  end
end
