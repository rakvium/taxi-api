FactoryGirl.define do
  factory :client do
    email { Faker::Internet.safe_email }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
