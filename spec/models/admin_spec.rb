require 'rails_helper'

RSpec.describe Admin, type: :model do
  context 'validation' do
    it 'should be valid' do
      expect(create(:admin)).to be_valid
    end
  end
end
