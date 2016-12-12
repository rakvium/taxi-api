require 'rails_helper'

RSpec.describe Driver, type: :model do
  context 'validation' do
    it 'should be valid' do
      expect(create(:driver)).to be_valid
    end
  end
end
