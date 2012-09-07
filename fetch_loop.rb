require './fetcher.rb'

fetcher = Fetcher.new
while true
  puts "Fetching"
  fetcher.execute
  puts "Sleeping "
  sleep 10
end
