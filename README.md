<center>
[![tamp3](https://img.skitch.com/20120304-xkxqnuwucfe1fnu4bxmpj34tn5.jpg)](https://skitch.com/alagu/8g6rm/download.rb)
</center>

## What you need

1. Grove.io account
2. Trello account
3. A bot account which could be added to your Trello boards could monitor all notifications
4. I have tested it on ruby 1.9.2-p320, not sure other versions work.

## Install 

NOTE: Trello doesn't have webhook, so this works on polling method.

1. Run bundle install
2. Create a token here - https://trello.com/1/appKey/generate
3. Create a bot user and add it to the board.
4. Get authorization token for the bot user - https://trello.com/1/authorize?key=YOUR_APP_ID&name=Markupwand&expiration=never&response_type=token&scope=read,write
5. Run the fetch_loop.rb in commandline, or just add an entry in cron