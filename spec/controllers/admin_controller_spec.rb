require 'rails_helper'
require 'rspec/json_expectations'
RSpec.describe AdminController, type: :controller do
  context 'POST #create_admin' do
    let(:admin) { create(:admin, name: 'admin', email: 'a@a.a', password: '123') }
    it 'can`t create admin without authenticated' do
      post :create_admin, format: :json, params: { name: admin.name, email: admin.email, password: admin.password }
      expect(JSON.parse(response.body)).to include_json(errors: ['Not Authenticated'])
    end
  end

  context 'POST #create_dispatcher' do
    let(:dispatcher) { create(:dispatcher, name: 'dispatcher', email: 'a@a.a', password: '123') }
    it 'can`t create dispatcher without authenticated' do
      post :create_dispatcher, format: :json, params: { name: dispatcher.name, email: dispatcher.email,
                                                        password: dispatcher.password }
      expect(JSON.parse(response.body)).to include_json(errors: ['Not Authenticated'])
    end
  end

  context 'POST #create_driver' do
    let(:driver) { create(:driver, name: 'driver', phone: '123', password: '123', auto: 'bmw') }
    it 'can`t create driver without authenticated' do
      post :create_driver, format: :json, params: { name: driver.name, phone: driver.phone, password: driver.password }
      expect(JSON.parse(response.body)).to include_json(errors: ['Not Authenticated'])
    end
  end
end
