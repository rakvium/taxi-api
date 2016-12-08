FactoryGirl.define do
  factory :admin do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(6, 12) }
    created_at { Faker::Date.between(2.days.ago, Time.zone.today) }
    updated_at { Faker::Date.between(2.days.ago, Time.zone.today) }
  end
end
