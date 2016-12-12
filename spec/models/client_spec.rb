require 'rails_helper'

RSpec.describe Client, type: :model do
  context 'validation' do
    it 'should be valid' do
      expect(build(:client)).to be_valid
    end
  end
end
