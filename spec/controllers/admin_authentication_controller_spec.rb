require 'rails_helper'

require 'rspec/json_expectations'
RSpec.describe AdminAuthenticationController, type: :controller do
  context 'POST #authenticate_admin' do
    let(:admin) { create(:admin, email: 'a@a.a', password: '123') }
    subject { post :authenticate_admin, format: :json, params: { email: admin.email, password: admin.password } }
    it 'admin receive token' do
      expect(JSON.parse(subject.body)).to include_json(
        auth_token: JsonWebToken.encode(user_id: admin.id, type: 'Admin'),
        admin: { id: admin.id, email: admin.email, type: 'Admin' }
      )
    end
  end
end
