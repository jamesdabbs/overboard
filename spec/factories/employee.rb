FactoryGirl.define do
  factory :employee do
    sequence(:email) { |n| "user#{n}@example.com" }
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }

    trait :with_account do
      user
    end
  end
end
