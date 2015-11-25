[![Build Status](https://travis-ci.org/therako/ruby-exercise.svg)](https://travis-ci.org/therako/ruby-exercise)

# A Giphy Bot for Twitter 
    This tweets random gifs found by the given keyword.

Setup,

  - source yoyr twitter credentials to the following environment variables,
      - TWITTER_CONSUMER_KEY
      - TWITTER_CONSUMER_SECRET
      - TWITTER_ACCESS_TOKEN
      - TWITTER_ACCESS_TOKEN_SECRET
  - Run the,
      - rake giphy:tweet_random_gif["Some keyword to search like 'ugh' or 'shrug'"]
