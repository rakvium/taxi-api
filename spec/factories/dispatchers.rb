FactoryGirl.define do
  factory :dispatcher do
    email { Faker::Internet.email }
    password { Faker::Internet.password(6, 12) }
    name { Faker::Name.first_name }
    created_at { Faker::Date.between(2.days.ago, Time.zone.today) }
    updated_at { Faker::Date.between(2.days.ago, Time.zone.today) }
  end
end
