# Ejaydj

[![Build Status](https://travis-ci.org/ejaypcanaria/ejaydj.svg)](https://travis-ci.org/ejaypcanaria/ejaydj)

A bot that tweets songs from your music playlists on Spotify. Implemented using Twitter and Spotify API, let your music be heard! This is where music really never stops.

## Installation

Add this line to your application's Gemfile:

    gem 'ejaydj'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ejaydj

## Configuration

### Prerequisites
1. [Twitter consumer and access token](https://developer.spotify.com/my-applications/#!/)
2. [Spotify client id and secret](https://apps.twitter.com/)

### Set the Spotify and Twitter credentials in your new TwitterBot DJ then add your playlists

```ruby
dj = Ejaydj::Djs::TwitterBot.new do |config|
  config.music_user_id               = 'spotify_user_id'
  config.music_client_id             = 'spotify_client_id'
  config.music_client_secret         = 'spotify_client_secret'

  config.twitter_consumer_key        = 'twitter_consumer_key'
  config.twitter_consumer_secret     = 'twitter_consumer_secret'
  config.twitter_access_token        = 'twitter_access_token'
  config.twitter_access_token_secret = 'twitter_access_token_secret'


  config.morning_playlists           = ["Morning Playlist 1", "Morning Playlist 2"]
  config.noon_playlists              = ["Noon Playlist 1", "Noon Playlist 2"]
  config.night_playlists             = ["Night Playlist 1", "Night Playlist 2"]
  config.late_night_playlists        = ["Late Night Playlist 1", "Late Night Playlist 2"]
end
```

**NOTE: You need to provide at least 1 playlist for each time spot**

## Tweeting Your Music
Given a `dj` object from the above configuration, tweeting your music is as simple as:
```ruby
  dj.tweet_me_a_song
```

The tweet format will look like:
`NP: {song} by {artist} from playlist: {playlist_url}`
Each songs is based on the provided time (default is current time). It will automatically lookup for tracks in the scheduled playlists.

## Playlists Schedule
Playlists are group into four time spots as you have seen in the configuration earlier. These time spots are:

1. Morning      - 6:00AM   - 11:59PM
2. Noon         - 12:00PM  - 5:59PM
3. Night        - 6:00PM   - 10:59PM
4. Late Night   - 11:PM    - 5:59AM

By default, the current time used is `Time.now`. You can override it by passing a `time` parameter on the `tweet_me_a_song` method:

```ruby
  dj.tweet_me_a_song(time: Time.new(2014, 11, 20, 14, 0, 0))
```


## Contributing

1. Fork it ( https://github.com/ejaypcanaria/ejaydj/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
