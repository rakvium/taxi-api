FactoryGirl.define do
  factory :order do
    client_id '1'
    driver_id '1'
    from { Faker::Address.street_address }
    to { Faker::Address.street_address }
    state 'Waiting'
    price { Faker::Number.decimal(3, 2) }
    created_at { Faker::Date.between(1.day.ago, Time.zone.today) }
    updated_at { Faker::Date.between(1.day.ago, Time.zone.today) }
  end
end
