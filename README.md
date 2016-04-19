[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)
# Overview

This ruby app looks for a tweet with hashtag #sad every hour and responds to it with a positive quote via @xiaomatong.


###Notes
* "Twitter" gem is employed in this application.
* A Class  named "twitterbot" is created to host the methods uses in this app.
* A rake file named "update_tweet" is created to call the methods.
* Heroku Scheduler is employed to run the rake task hourly.
  
###Cool response from fellow Twitter users 
![Screenshot 1](doc/screen1.jpg)

![Screenshot 2](doc/screen2.jpg)

![Screenshot 3](doc/screen3.jpg)

![Screenshot 4](doc/screen4.jpg)