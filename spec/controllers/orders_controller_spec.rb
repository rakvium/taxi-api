require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  context 'GET #index' do
    it 'when not logged in' do
      get :index
      expect(response).to have_http_status(401)
    end

    it 'when logged in as driver' do
      driver = Driver.create FactoryGirl.attributes_for(:driver)
      token = JsonWebToken.encode(user_id: driver.id, type: 'Driver')
      request.headers['Authorization'] = token
      get :index
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to include_json(orders: [])
    end

    it 'when logged in as admin' do
      admin = Admin.create FactoryGirl.attributes_for(:admin)
      token = JsonWebToken.encode(user_id: admin.id, type: 'Admin')
      request.headers['Authorization'] = token
      get :index
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to include_json(orders: [])
    end

    it 'when logged in as dispatcher' do
      dispatcher = Dispatcher.create FactoryGirl.attributes_for(:dispatcher)
      token = JsonWebToken.encode(user_id: dispatcher.id, type: 'Dispatcher')
      request.headers['Authorization'] = token
      get :index
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to include_json(orders: [])
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
