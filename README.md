# Color My Hex #

Color My Hex is a Twitter Bot that helps you work with hex color codes.

* If you tweet to @colormyhex with a hex value, it will reply with an image of the associated color
* If you tweet to @colormyhex with an image, it will reply with the hex code of the most dominant color in the image

## Hosting ##

The app is hosted on Heroku at [ColorMyHex](http://colormyhex.herokuapp.com) and uses the Twitter account [@colormyhex](https://twitter.com/colormyhex)

## Installation ##

1. Run `bundle install` 
2. Create an app at  [Twitter App Dev](https://apps.twitter.com)
3. Add a file with the below code at `/config/twitter.yml` with twitter access tokens that you get from your [Twitter App Dashboard](https://apps.twitter.com)

- ```ruby
consumer_key: XXX
consumer_secret: XXX
access_token: XXX
access_token_secret: XXX
```

## Gems used ##
* Twitter gem
* Colorscore gem
* Chunky PNG