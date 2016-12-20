require 'rails_helper'

require 'rspec/json_expectations'
RSpec.describe DispatchersController, type: :controller do
  context 'POST #create' do
    subject { FactoryGirl.attributes_for(:dispatcher) }
    let!(:disp) { Dispatcher.create subject }

    it 'when all parameters is good' do
      post :create, params: subject
      expect(response.status).to eq 200
      expect(JSON.parse(response.body)).to include_json(
        auth_token: JsonWebToken.encode(user_id: disp[:id], type: 'dispatcher'),
        dispatcher: { id: disp[:id], email: disp[:email], type: 'dispatcher' }
      )
    end

    it 'when wrong password' do
      subject[:password] = ''
      post :create, params: subject
      expect(response.status).to eq 422
      expect(JSON.parse(response.body)).to include_json(errors: ['Invalid password'])
    end

    it 'when wrong email' do
      subject[:email] = ''
      post :create, params: subject
      expect(response.status).to eq 422
      expect(JSON.parse(response.body)).to include_json(errors: ['Invalid email'])
    end
  end
end
