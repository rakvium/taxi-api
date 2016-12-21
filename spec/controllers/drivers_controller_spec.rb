require 'rails_helper'

require 'rspec/json_expectations'
RSpec.describe DriversController, type: :controller do
  context 'POST #create' do
    subject { FactoryGirl.attributes_for(:driver) }
    let!(:drive) { Driver.create subject }

    it 'when all parameters are good' do
      post :create, params: subject
      expect(response.status).to eq 200
      expect(JSON.parse(response.body)).to include_json(
        auth_token: JsonWebToken.encode(user_id: drive[:id], type: 'Driver'),
        driver: { id: drive[:id], phone: drive[:phone], type: 'Driver' }
      )
    end

    it 'when wrong password' do
      subject[:password] = ''
      post :create, params: subject
      expect(response.status).to eq 422
      expect(JSON.parse(response.body)).to include_json(errors: ['Invalid password'])
    end

    it 'when wrong email' do
      subject[:phone] = ''
      post :create, params: subject
      expect(response.status).to eq 422
      expect(JSON.parse(response.body)).to include_json(errors: ['Invalid phone'])
    end
  end
end
