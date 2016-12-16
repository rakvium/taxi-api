require 'rails_helper'

RSpec.describe AdminAuthenticationController, type: :controller do
  context 'POST #payload' do
    it 'when admin recieve token' do
      expect do
        post :payload, params: { auth_token: JsonWebToken.encode(user_id: 1, type: 'admin') }
      end
    end
  end
end
