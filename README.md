[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)
# Overview #

Write a simple Ruby app that tweets about something of your choice every hour or responds when tweeted at.

We have provided an example rails app here as it facilitates hosting on Heroku, but you are welcome to use any solution in Ruby.

There is no one way to complete this exercise as long as the minimum requirements are met.
When you are finished, please send us a pull request of the finished product.
A clean Git History (with relevant commit messages) is a bonus.

Your code should be performant and intuitive.

Any questions, please ask.

Notes:
  - There are various twitter API gems available, no need to write your own access.
      - Search https://www.ruby-toolbox.com for more info on your options.

  - Heroku Scheduler is a simple Heroku add-on for background jobs.

  - The point of this isn't to stress about what to tweet, so some examples are:
    - Find anagrams in others tweets
    - Look for accidental haiku in tweets and reformat then retweet
    - Looks for song lyrics in tweets and posts song names
    - Grabs tweets, puts it through a text-to-speech api and posts a link to the audio
    - Two bots playing chess together.
    - Random words from a dictionary
    - @reply a sample image of a colour if you tweet a hexcode at the bot.
    - Snowball poems 
    - Sports results
    - Battleships

### To tweet a quote ###
> bundle exec rake bot:tweet\_a\_quote

### To handle user stream with auto replies ###
> bundle exec rake twitter\_streamer:start
