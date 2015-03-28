FactoryGirl.define do
  factory :course do
    instructor { create :employee }
    campus
    topic
    start_on { rand(-3..3).weeks.from_now }
  end
end
