require 'rails_helper'

RSpec.describe AdminAuthenticationController, type: :controller do
  context 'POST #authenticate_admin' do
    it 'when all parameters is good' do
      expect do
        post :authenticate_admin, params: { admin: FactoryGirl.attributes_for(:admin) }
      end.to change(Admin, :count).by(1)
    end
  end
end
