[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

# Setup

- `cp config/secrets.sample.yml config/secrets.yml`
- Go to [https://apps.twitter.com/](https://apps.twitter.com/) and setup new twitter app
- Add secrets to `config/secrets.yml` for new twitter app
- `bundle install`

# Usage

Run `bundle exec rake dream["keyword"]` where `keyord` is what you search on twitter

# Heroku

 TODO
