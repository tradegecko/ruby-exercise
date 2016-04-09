FactoryGirl.define do
  factory :tweet do
    sequence(:content) {|n| "Content #{n}" }
    tweeted_on nil
    mention
  end
end
