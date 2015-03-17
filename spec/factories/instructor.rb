FactoryGirl.define do
  factory :instructor do
    name { Faker::Name.name }

    trait :with_account do
      user
    end
  end
end
