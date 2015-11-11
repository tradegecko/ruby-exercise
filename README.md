[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

# Setup

- `cp .env.sample .env`
- Go to [https://apps.twitter.com/](https://apps.twitter.com/) and setup new twitter app
- Add secrets from the new twitter app to your `.env` file
- `bundle install`

# Usage

Run `bundle exec rake dream["keyword"]` where `keyord` is what you search on twitter

# Heroku

## Secrets

[Add secrets to Heroku](https://devcenter.heroku.com/articles/config-vars):

```
SECRET_KEY_BASE
TWITTER_CONSUMER_KEY
TWITTER_CONSUMER_SECRET
TWITTER_ACCESS_TOKEN
TWITTER_ACCESS_TOKEN_SECRET
```

## Rake Task

Add `bundle exec rake dream` to [Heroku Scheduler](https://devcenter.heroku.com/articles/scheduler).
