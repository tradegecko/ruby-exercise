[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)
# Overview #

A Rails app that finds the most recent tweet with images by a single keyword and then process them with deep dreaming algorithm, and lastly tweet new images at [@deepdreaming_](https://twitter.com/deepdreaming_).

# Setup

* `cp .env.sample .env`
* Go to [https://apps.twitter.com/](https://apps.twitter.com/) and setup new twitter app
* Add secrets from the new twitter app to your `.env` file
* `bundle`


## Usage
Update `DREAM_KEYWORD` environment variable when changing searched keyword, default value is `dream`.

## Gem Used 
* `sidekiq` for job processing
* `http` for high performance http handling
* `twitter` for interacting with twitter


## Heroku Addons 
* `Heroku Scheduler` for simple rake task invoking
* `Redis To Go` for supporting `sidekiq`


## Secrets

[Add secrets to Heroku](https://devcenter.heroku.com/articles/config-vars):

```
TWITTER_CONSUMER_KEY
TWITTER_CONSUMER_SECRET
TWITTER_ACCESS_TOKEN
TWITTER_ACCESS_TOKEN_SECRET
DREAM_KEYWORD
```

## Rake Task with Heroku Scheduler

Add `rake deep_dream` to [Heroku Scheduler](https://devcenter.heroku.com/articles/scheduler).
