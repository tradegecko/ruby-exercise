FactoryGirl.define do
  factory :mention do
    content "@daebakbot Hello"
    screen_name "@sender"
    sequence(:mention_tweet_id) {|n| n.to_s.rjust(9, '0')}
    reply_content nil
  end
end
