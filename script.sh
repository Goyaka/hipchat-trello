# Specific to markupwand
# 
# #crontab -e
# */10 * * * * bash /home/ubuntu/markupwand-jobs/grove-trello/script.sh
cd /home/ubuntu/markupwand-jobs/grove-trello/
ruby fetch_once.rb
