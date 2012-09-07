# Specific to markupwand
# 
# #crontab -e
# */10 * * * * bash /home/ubuntu/markupwand-jobs/grove-trello/script.sh
export PATH=/usr/local/rvm/bin:$PATH
. /usr/local/rvm/scripts/rvm
rvm use 1.9.2-p320
cd /home/ubuntu/markupwand-jobs/grove-trello/
ruby --version
ruby fetch_once.rb
