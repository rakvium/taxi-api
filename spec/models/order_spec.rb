require 'rails_helper'

RSpec.describe Order, type: :model do
  before(:each) do
    @client = FactoryGirl.create(:client)
    @client.id = 1
    @client.save
  end
  context 'validation' do
    it 'should be valid' do
      expect(create(:order)).to be_valid
    end
  end
end
