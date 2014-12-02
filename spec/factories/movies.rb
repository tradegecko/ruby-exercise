FactoryGirl.define do
  factory :movie do
    sequence(:title) { |n| "title-#{n}" }
  end
end
