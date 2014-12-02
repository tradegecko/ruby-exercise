[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://sentwix.herokuapp.com/)
# Overview #

Sentwix is an automated movie rating system. Movies can be added to Sentwix movie list and a rating will be generated automatically.

How It Works
Sentwix extracts data from Twitter about a movie and performs a sentiment analysis on the tweet. This is done every hour.
The mean of the senitment scores for each sample is calculated and then mapped onto a Rating function.
The overall score reflects the latest rating of the movie based on the hourly analysis.

Technical Design
Data: Postgres, Hstore
Backend: Ruby on Rails, Sidekiq for background jobs
Sentiment Analysis: Alchemy API
