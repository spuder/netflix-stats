#!/bin/env ruby
require 'CSV'

csv = CSV.parse(File.read('NetflixViewingHistory.csv'), headers: true)

# Create new array containing all the dates shows were watched
daily_count = Hash.new()
# When ruby 2.7 is released, this will be much simpler by using '.tally'
# https://stackoverflow.com/a/48053739/1626687
csv.each do |row|
    date=row[1]
    unless daily_count[date]
        daily_count[date] = 1 
    else
        daily_count[date] += 1
    end
end

# daily_count.sort_by { |k, v| k}.to_h

puts "Writing to NetflixTally.csv"
CSV.open('NetflixTally.csv', 'w', 
    :write_headers=> true, 
    :headers => ['Date','Count']
    ) do |row|
    daily_count.each do |k,v|
        row << [k,v]
    end
end