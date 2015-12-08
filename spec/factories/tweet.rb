FactoryGirl.define do
  factory :tweet do
    twitter_ref 123456
    text 'hello'
    gif
    created_at Time.zone.now
  end
end