require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'validation' do
    it 'should be valid' do
      expect(create(:order)).to be_valid
    end
  end
end
