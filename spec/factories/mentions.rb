FactoryGirl.define do
  factory :mention do
    content "@daebakbot Hello"
    sequence(:sender_twitter_id) {|n| n.to_s.rjust(9, '0')}
    sequence(:mention_tweet_id) {|n| n.to_s.rjust(9, '0')}
    reply_content nil
  end
end
