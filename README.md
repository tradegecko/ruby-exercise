[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)
## PokeQwiz ##
#### A pokemon quiz implementation using a twitter account ####

**Features**
* Handles multiple quiz sessions with different accounts simultaneously
* Can support upto 720 available pokemons
* Caches data locally to prevent network calls
* Replies with different texts to avoid robotic response

**TODO**
* Complete test code for everything
* Add support for 'help' and 'report' commands
* Add more non-robotic response feel

**Configuration**

Requires the following environment variables to be set
* TWITTER_SCREENNAME _#Important to set it to the quiz account. Otherwise results in endless loop._
* TWITTER_CONSUMER_KEY
* TWITTER_CONSUMER_SECRET
* TWITTER_MAIN_ACCESS_TOKEN
* TWITTER_MAIN_ACCESS_TOKEN_SECRET

**Screenshot**

![pq screenshot](https://raw.githubusercontent.com/vigneshwaranr/ruby-exercise/master/public/screenshot.jpg)
