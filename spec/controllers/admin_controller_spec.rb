require 'rails_helper'
require 'rspec/json_expectations'
RSpec.describe AdminController, type: :controller do
  context 'POST #create_admin' do
    it 'can`t create admin if not authenticated as an admin' do
      post :create_admin, format: :json, params: { name: 'admin', email: 'admin@email.com', password: 'password' }
      expect(JSON.parse(response.body)).to include_json(errors: ['Not Authenticated'])
    end
    it 'can create admin ' do
      current_admin = Admin.create FactoryGirl.attributes_for(:admin)
      token = JsonWebToken.encode(user_id: current_admin.id, type: 'admin')
      request.headers['Authorization'] = token
      post :create_admin, format: :json, params: { admin: { name: 'admin', email: 'admin@email.com', password: 'password' } }
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
      current_admin = Admin.create FactoryGirl.attributes_for(:admin)
      token = JsonWebToken.encode(user_id: current_admin.id, type: 'admin')
      request.headers['Authorization'] = token
      post :create_dispatcher, format: :json, params: { dispatcher: { name: 'dispatcher', email: 'dispatcher@email.com', password: 'password' } }
      expect(JSON.parse(response.body)).to include_json(name: 'dispatcher', email: 'dispatcher@email.com')
    end
  end

  context 'POST #create_driver' do
    it 'can`t create driver if not authenticated as an admin' do
      post :create_driver, format: :json, params: { driver: { name: 'vasya', phone: '123456', password: '123123', auto: 'bmw' } }
      expect(JSON.parse(response.body)).to include_json(errors: ['Not Authenticated'])
    end
    it 'can create driver' do
      current_admin = Admin.create FactoryGirl.attributes_for(:admin)
      token = JsonWebToken.encode(user_id: current_admin.id, type: 'admin')
      request.headers['Authorization'] = token
      post :create_driver, format: :json, params: { driver: { name: 'vasya', phone: '123456', password: '123123', auto: 'bmw' } }
      expect(JSON.parse(response.body)).to include_json(name: 'vasya', phone: '123456', auto: 'bmw')
    end
  end

  context 'GET #index' do
    it 'when logged in as admin' do
      admin = Admin.create FactoryGirl.attributes_for(:admin)
      token = JsonWebToken.encode(user_id: admin.id, type: 'admin')
      request.headers['Authorization'] = token
      get :index, format: :json
      expect(JSON.parse(response.body)).to include_json('logged_in' => true)
    end
  end
end
