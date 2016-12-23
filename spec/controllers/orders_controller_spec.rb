require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'GET #index' do
    context 'when not logged in' do
      it 'should return 401' do
        get :index
        expect(response).to have_http_status(401)
      end
    end

    context 'when logged in as driver' do
      let(:driver) { Driver.create FactoryGirl.attributes_for(:driver) }

      it 'should return list of orders' do
        token = JsonWebToken.encode(user_id: driver.id, type: 'Driver')
        request.headers['Authorization'] = token
        get :index
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to include_json(orders: [])
      end
    end

    context 'when logged in as admin' do
      let(:admin) { Admin.create FactoryGirl.attributes_for(:admin) }

      it 'should return list of orders' do
        token = JsonWebToken.encode(user_id: admin.id, type: 'Admin')
        request.headers['Authorization'] = token
        get :index
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to include_json(orders: [])
      end
    end

    context 'when logged in as dispatcher' do
      let(:dispatcher) { Dispatcher.create FactoryGirl.attributes_for(:dispatcher) }

      it 'should return list of orders' do
        token = JsonWebToken.encode(user_id: dispatcher.id, type: 'Dispatcher')
        request.headers['Authorization'] = token
        get :index
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to include_json(orders: [])
      end
    end

    context 'when account is blocked' do
      let(:admin) { Admin.create FactoryGirl.attributes_for(:admin) }

      it 'should return 403' do
        Admin.update(admin.id, blocked: true)
        token = JsonWebToken.encode(user_id: admin.id, type: 'Admin')
        request.headers['Authorization'] = token
        get :index
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'POST #create' do
    let(:order) { FactoryGirl.attributes_for(:order) }
    let(:client) { FactoryGirl.attributes_for(:client) }

    context 'when all parameters are good' do
      it 'should add order' do
        expect do
          post :create, params: { order: order, client: client }
        end.to change(Order, :count).by(1)
      end
    end

    context 'when wrong order parameter' do
      it 'should return 422' do
        order[:from] = ''
        post :create, params: { order: order, client: client }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when wrong client parameter' do
      it 'should return 422' do
        client[:phone] = ''
        post :create, params: { order: order, client: client }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show' do
    let(:client) { Client.create FactoryGirl.attributes_for(:client) }
    let(:driver) { Driver.create FactoryGirl.attributes_for(:driver) }
    before :each do
      params = { client_id: client.id }.merge(FactoryGirl.attributes_for(:order))
      @order = Order.create params
    end

    context 'when logged in' do
      it 'should return order' do
        token = JsonWebToken.encode(user_id: driver.id, type: 'Driver')
        request.headers['Authorization'] = token
        get :show, params: { id: @order.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to include_json(order: [])
      end
    end

    context 'when not logged in' do
      it 'should return 401' do
        get :show, params: { id: @order.id }
        expect(response).to have_http_status(401)
      end
    end

    context 'when account is blocked' do
      let(:admin) { Admin.create FactoryGirl.attributes_for(:admin) }

      it 'should return 403' do
        Admin.update(admin.id, blocked: true)
        token = JsonWebToken.encode(user_id: admin.id, type: 'Admin')
        request.headers['Authorization'] = token
        get :show, params: { id: @order.id }
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'PATCH #update' do
    let(:client) { Client.create FactoryGirl.attributes_for(:client) }
    let(:dispatcher) { Dispatcher.create FactoryGirl.attributes_for(:dispatcher) }
    let(:driver) { Driver.create FactoryGirl.attributes_for(:driver) }
    before :each do
      params = { client_id: client.id }.merge(FactoryGirl.attributes_for(:order))
      @order = Order.create params
    end

    context 'when logged in as driver' do
      it 'should return 403' do
        token = JsonWebToken.encode(user_id: driver.id, type: 'Driver')
        request.headers['Authorization'] = token
        patch :update, params: { id: @order.id }
        expect(response).to have_http_status(403)
      end
    end

    context 'when logged in as dispatcher' do
      it 'should change order' do
        token = JsonWebToken.encode(user_id: dispatcher.id, type: 'Dispatcher')
        request.headers['Authorization'] = token
        patch :update, params: { id: @order.id, order: FactoryGirl.attributes_for(:order) }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to include_json(current_order: [])
      end
    end

    context 'when not logged in' do
      it 'should return 401' do
        patch :update, params: { id: @order.id }
        expect(response).to have_http_status(401)
      end
    end

    context 'when account is blocked' do
      let(:admin) { Admin.create FactoryGirl.attributes_for(:admin) }

      it 'should return 403' do
        Admin.update(admin.id, blocked: true)
        token = JsonWebToken.encode(user_id: admin.id, type: 'Admin')
        request.headers['Authorization'] = token
        get :update, params: { id: @order.id }
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'PATCH #apply' do
    let(:client) { Client.create FactoryGirl.attributes_for(:client) }
    let(:driver) { Driver.create FactoryGirl.attributes_for(:driver) }
    before :each do
      params = { client_id: client.id }.merge(FactoryGirl.attributes_for(:order))
      @order = Order.create params
    end

    context 'when logged in as driver' do
      it 'should change order status to \'in progress\'' do
        token = JsonWebToken.encode(user_id: driver.id, type: 'Driver')
        request.headers['Authorization'] = token
        patch :apply, params: { id: @order.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to include_json(current_order: [])
        expect(Order.find(@order.id).state).to eq 'active'
      end
    end

    context 'when not logged in' do
      it 'should return 401' do
        patch :apply, params: { id: @order.id }
        expect(response).to have_http_status(401)
      end
    end

    context 'when account is blocked' do
      let(:admin) { Admin.create FactoryGirl.attributes_for(:admin) }

      it 'should return 403' do
        Admin.update(admin.id, blocked: true)
        token = JsonWebToken.encode(user_id: admin.id, type: 'Admin')
        request.headers['Authorization'] = token
        get :apply, params: { id: @order.id }
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'PATCH #cancel' do
    let(:client) { Client.create FactoryGirl.attributes_for(:client) }
    let(:dispatcher) { Dispatcher.create FactoryGirl.attributes_for(:dispatcher) }
    let(:driver) { Driver.create FactoryGirl.attributes_for(:driver) }
    before :each do
      params = { client_id: client.id }.merge(FactoryGirl.attributes_for(:order))
      @order = Order.create params
    end

    context 'when logged in as dispatcher or admin' do
      it 'should change order status to \'canceled\'' do
        token = JsonWebToken.encode(user_id: dispatcher.id, type: 'Dispatcher')
        request.headers['Authorization'] = token
        patch :cancel, params: { id: @order.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to include_json(current_order: [])
        expect(Order.find(@order.id).state).to eq 'canceled'
      end
    end

    context 'when logged in as driver' do
      it 'should return 403' do
        token = JsonWebToken.encode(user_id: driver.id, type: 'Driver')
        request.headers['Authorization'] = token
        patch :cancel, params: { id: @order.id }
        expect(response).to have_http_status(403)
      end
    end

    context 'when not logged in' do
      it 'should return 401' do
        patch :cancel, params: { id: @order.id }
        expect(response).to have_http_status(401)
      end
    end

    context 'when account is blocked' do
      let(:admin) { Admin.create FactoryGirl.attributes_for(:admin) }

      it 'should return 403' do
        Admin.update(admin.id, blocked: true)
        token = JsonWebToken.encode(user_id: admin.id, type: 'Admin')
        request.headers['Authorization'] = token
        get :cancel, params: { id: @order.id }
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'PATCH #complete' do
    let(:client) { Client.create FactoryGirl.attributes_for(:client) }
    let(:dispatcher) { Dispatcher.create FactoryGirl.attributes_for(:dispatcher) }
    let(:driver) { Driver.create FactoryGirl.attributes_for(:driver) }
    before :each do
      params = { client_id: client.id }.merge(FactoryGirl.attributes_for(:order))
      @order = Order.create params
    end

    context 'when logged in as dispatcher or admin' do
      it 'should change order status to \'canceled\'' do
        token = JsonWebToken.encode(user_id: driver.id, type: 'Driver')
        request.headers['Authorization'] = token
        patch :complete, params: { id: @order.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to include_json(current_order: [])
        expect(Order.find(@order.id).state).to eq 'completed'
      end
    end

    context 'when logged in as driver' do
      it 'should return 403' do
        token = JsonWebToken.encode(user_id: dispatcher.id, type: 'Dispatcher')
        request.headers['Authorization'] = token
        patch :complete, params: { id: @order.id }
        expect(response).to have_http_status(403)
      end
    end

    context 'when not logged in' do
      it 'should return 401' do
        patch :complete, params: { id: @order.id }
        expect(response).to have_http_status(401)
      end
    end

    context 'when account is blocked' do
      let(:admin) { Admin.create FactoryGirl.attributes_for(:admin) }

      it 'should return 403' do
        Admin.update(admin.id, blocked: true)
        token = JsonWebToken.encode(user_id: admin.id, type: 'Admin')
        request.headers['Authorization'] = token
        get :complete, params: { id: @order.id }
        expect(response).to have_http_status(403)
      end
    end
  end
end
