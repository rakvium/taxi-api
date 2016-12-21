require 'rails_helper'

RSpec.describe DriversController, type: :controller do
  context 'POST #create' do
    subject { FactoryGirl.attributes_for(:driver) }
    let!(:driver) { Driver.create subject }

    it 'when all parameters are good' do
      post :create, params: subject
      expect(response.status).to eq 200
      expect(JSON.parse(response.body)).to include_json(
        auth_token: JsonWebToken.encode(user_id: driver[:id], type: 'Driver'),
        driver: { id: driver[:id], phone: driver[:phone], type: 'Driver' }
      )
    end

    it 'when wrong password' do
      subject[:password] = ''
      post :create, params: subject
      expect(response.status).to eq 422
      expect(JSON.parse(response.body)).to include_json(errors: ['Invalid password'])
    end

    it 'when wrong phone' do
      subject[:phone] = ''
      post :create, params: subject
      expect(response.status).to eq 422
      expect(JSON.parse(response.body)).to include_json(errors: ['Invalid phone'])
    end
  end
end
