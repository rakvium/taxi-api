require 'rails_helper'

RSpec.describe Driver, type: :model do
  context 'validation' do
    it 'should be valid' do
      expect(build(:dispatcher)).to be_valid
    end
  end
end
