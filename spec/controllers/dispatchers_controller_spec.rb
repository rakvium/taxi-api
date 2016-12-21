require 'rails_helper'

RSpec.describe DispatchersController, type: :controller do
  context 'POST #create' do
    subject { FactoryGirl.attributes_for(:dispatcher) }
    let!(:dispatcher) { Dispatcher.create subject }

    it 'when all parameters are good' do
      post :create, params: subject
      expect(response.status).to eq 200
      expect(JSON.parse(response.body)).to include_json(
        auth_token: JsonWebToken.encode(user_id: dispatcher[:id], type: 'Dispatcher'),
        dispatcher: { id: dispatcher[:id], email: dispatcher[:email], type: 'Dispatcher' }
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
