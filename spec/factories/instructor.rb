FactoryGirl.define do
  factory :instructor do
    sequence(:email) { |n| "user#{n}@example.com" }
    name { Faker::Name.name }

    trait :with_account do
      user
    end
  end
end
