FactoryGirl.define do
  factory :driver do
    name { Faker::Name.first_name }
    phone { Faker::PhoneNumber.cell_phone }
    encrypted_password { Faker::Internet.password(6, 12) }
    auto { Faker::Name.first_name }
  end
end
