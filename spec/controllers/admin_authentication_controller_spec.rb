require 'rails_helper'

RSpec.describe AdminAuthenticationController, type: :controller do
  context 'POST #authenticate_admin' do
    let(:admin) { create(:admin, email: 'a@a.a', password: '123') }
    it 'admin recieve token' do
      post :authenticate_admin, format: :json, params: { email: admin.email, password: admin.password }
      expect(response).to be_success
    end
  end
end
