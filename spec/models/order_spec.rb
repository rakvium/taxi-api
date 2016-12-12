require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'validation' do
    it 'should be valid when created by the fabric' do
      expect(create(:order)).to be_valid
    end
  end
end
