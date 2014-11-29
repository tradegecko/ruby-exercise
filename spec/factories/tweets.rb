FactoryGirl.define do
  factory :tweet do
    sequence(:object) { |n| {id: "#{n}"} }
    sentiment { [-1,0,1].sample }
  end
end
