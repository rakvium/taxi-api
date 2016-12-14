FactoryGirl.define do
  factory :client do
    email { Faker::Internet.safe_email }
    phone { Faker::Number.number(10) }
  end
end
