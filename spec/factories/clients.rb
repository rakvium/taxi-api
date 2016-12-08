FactoryGirl.define do
  factory :client do
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
