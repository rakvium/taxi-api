FactoryGirl.define do
  factory :admin do
    name { Faker::Name.first_name }
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password(6, 12) }
  end
end
