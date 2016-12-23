require 'rails_helper'
require 'rspec/json_expectations'
RSpec.describe AdminController, type: :controller do
  let!(:current_admin) { Admin.create FactoryGirl.attributes_for(:admin) }
  let!(:admin) { Admin.create FactoryGirl.attributes_for(:admin) }

  context 'GET #index' do
    it 'show all admins' do
      token = JsonWebToken.encode(user_id: admin.id, type: 'Admin')
      request.headers['Authorization'] = token
      get :index, format: :json
      expect(JSON.parse(response.body)).to include_json([])
    end
  end

  context 'GET #index_driver' do
    it 'show all drivers' do
      token = JsonWebToken.encode(user_id: admin.id, type: 'Admin')
      request.headers['Authorization'] = token
      get :index_driver, format: :json
      expect(JSON.parse(response.body)).to include_json([])
    end
  end

  context 'GET #index_dispatcher' do
    it 'show all dispatchers' do
      token = JsonWebToken.encode(user_id: admin.id, type: 'Admin')
      request.headers['Authorization'] = token
      get :index_dispatcher, format: :json
      expect(JSON.parse(response.body)).to include_json([])
    end
  end

  context 'GET #index_client' do
    it 'show all clients' do
      token = JsonWebToken.encode(user_id: admin.id, type: 'Admin')
      request.headers['Authorization'] = token
      get :index_client, format: :json
      expect(JSON.parse(response.body)).to include_json([])
    end
  end

  context 'POST #create' do
    it 'can`t create admin if not authenticated as an admin' do
      post :create, format: :json, params: { name: 'admin', email: 'admin@email.com', password: 'password' }
      expect(JSON.parse(response.body)).to include_json(errors: ['Not Authenticated'])
    end
    it 'can create admin ' do
      token = JsonWebToken.encode(user_id: current_admin.id, type: 'Admin')
      request.headers['Authorization'] = token
      post :create, format: :json, params: { admin: {
        name: 'admin',
        email: 'admin@email.com',
        password: 'password'
      } }
      expect(JSON.parse(response.body)).to include_json(name: 'admin', email: 'admin@email.com')
    end
  end

  context 'POST #create_dispatcher' do
    it 'can`t create dispatcher if not authenticated as an admin' do
      post :create_dispatcher, format: :json, params: { name: 'dispatcher', email: 'dispatcher@email.com',
                                                        password: 'password' }
      expect(JSON.parse(response.body)).to include_json(errors: ['Not Authenticated'])
    end

    it 'can create dispatcher' do
      token = JsonWebToken.encode(user_id: current_admin.id, type: 'Admin')
      request.headers['Authorization'] = token
      post :create_dispatcher, format: :json, params: { dispatcher: {
        name: 'dispatcher',
        email: 'dispatcher@email.com',
        password: 'password'
      } }
      expect(JSON.parse(response.body)).to include_json(name: 'dispatcher', email: 'dispatcher@email.com')
    end
  end

  context 'POST #create_driver' do
    it 'can`t create driver if not authenticated as an admin' do
      post :create_driver, format: :json, params: { driver: {
        name: 'vasya',
        phone: '123456',
        password: '123123',
        auto: 'bmw'
      } }
      expect(JSON.parse(response.body)).to include_json(errors: ['Not Authenticated'])
    end

    it 'can create driver' do
      token = JsonWebToken.encode(user_id: current_admin.id, type: 'Admin')
      request.headers['Authorization'] = token
      post :create_driver, format: :json, params: { driver: {
        name: 'vasya',
        phone: '123456',
        password: '123123',
        auto: 'bmw'
      } }
      expect(JSON.parse(response.body)).to include_json(name: 'vasya', phone: '123456', auto: 'bmw')
    end
  end
  context 'PUT #update' do
    it 'can update admin' do
      token = JsonWebToken.encode(user_id: current_admin.id, type: 'Admin')
      request.headers['Authorization'] = token
      put :update, format: :json, params: { id: admin.id, admin: {
        name: 'vasya',
        email: 'a@a.c',
        password: '123123'
      } }
      expect(JSON.parse(response.body)).to include_json(name: 'vasya', email: 'a@a.c')
    end
  end
end
