require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  context 'GET #index' do
    it 'should be good' do
      get :index, format: :json
      expect(response).to be_success
    end
  end

  context 'POST #create' do
    let(:order) { FactoryGirl.attributes_for(:order) }
    let(:client) { FactoryGirl.attributes_for(:client) }

    it 'when all parameters are good' do
      expect do
        post :create, params: { order: order, client: client }
      end.to change(Order, :count).by(1)
    end

    it 'when wrong order parameter' do
      order[:from] = ''
      post :create, params: { order: order, client: client }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'when wrong client parameter' do
      client[:phone] = ''
      post :create, params: { order: order, client: client }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
