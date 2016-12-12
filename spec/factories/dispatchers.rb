FactoryGirl.define do
  factory :dispatcher do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password(6, 12) }
    name { Faker::Name.first_name }
  end
end
