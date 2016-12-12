require 'rails_helper'

RSpec.describe Dispatcher, type: :model do
  context 'validation' do
    it 'should be valid when created by the fabric' do
      expect(create(:dispatcher)).to be_valid
    end
  end
end
