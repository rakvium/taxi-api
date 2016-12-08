FactoryGirl.define do
  factory :client do
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    created_at { Faker::Date.between(2.days.ago, Time.zone.today) }
    updated_at { Faker::Date.between(2.days.ago, Time.zone.today) }
  end
end
