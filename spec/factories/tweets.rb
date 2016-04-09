FactoryGirl.define do
  factory :tweet do
    sequence(:content) {|n| "Content #{n} #{Time.now}" }
    tweeted_on nil
  end
end
