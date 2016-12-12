FactoryGirl.define do
  factory :order do
    client FactoryGirl.create(:client)
    from { Faker::Address.street_address }
    to { Faker::Address.street_address }
    state 'Waiting'
    price { Faker::Number.decimal(3, 2) }
  end
end
