FactoryGirl.define do
  factory :driver do
    name { Faker::Name.first_name }
    phone { Faker::Number.number(10) }
    encrypted_password { Faker::Internet.password(6, 12) }
    auto { Faker::Name.first_name }
  end
end
