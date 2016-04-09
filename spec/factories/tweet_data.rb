FactoryGirl.define do
  factory :tweet_datum, class: 'TweetData' do
    content "This is the tweet text"
    hashtag "kpop"
  end
end
