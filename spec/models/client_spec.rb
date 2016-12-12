require 'rails_helper'

RSpec.describe Client, type: :model do
  context 'validation' do
    it 'should be valid when created by the fabric' do
      expect(create(:client)).to be_valid
    end
  end
end
