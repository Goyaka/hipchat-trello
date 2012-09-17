<center>
[![grove-hipchat](http://cl.ly/image/3l1X2v132R1i/Screen%20Shot%202012-09-16%20at%206.29.31%20PM.png)](http://cl.ly/image/3l1X2v132R1i/Screen%20Shot%202012-09-16%20at%206.29.31%20PM.png)
</center>

## What you need

1. Hipchat account
2. Trello account
3. A bot account which could be added to your Trello boards could monitor all notifications
4. I have tested it on ruby 1.9.2-p320, not sure other versions work.
5. A ubuntu machine (aws-like) which can run your cron, or a loop.

## Install 

NOTE: Trello doesn't have webhook, so this works on polling method.

1. Run bundle install
2. Create your trello app - [trello api](https://trello.com/1/appKey/generate)
3. Create a copy of config.yml.sample as config.yml, copy the above key here.
4. Create a bot user and add it to the board.
5. Get authorization token for the bot user

    https://trello.com/1/authorize?key=YOUR_APP_ID&name=Markupwand&expiration=never&response_type=token&scope=read,write,account
5. Save the auth token in config.yml

5. Run the fetch_loop.rb in commandline, or just add an entry in cron
