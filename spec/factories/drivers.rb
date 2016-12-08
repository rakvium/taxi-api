FactoryGirl.define do
  factory :driver do
    name { Faker::Name.first_name }
    phone { Faker::PhoneNumber.cell_phone }
    encrypted_password { Faker::Internet.password(6, 12) }
    auto { Faker::Name.first_name }
    created_at { Faker::Date.between(2.days.ago, Time.zone.today) }
    updated_at { Faker::Date.between(2.days.ago, Time.zone.today) }
  end
end
