require './fetcher.rb'

fetcher = Fetcher.new
while true
  fetcher.execute
  print "."
  sleep 10
end
