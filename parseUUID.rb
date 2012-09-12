#!/usr/bin/env ruby

require 'rubygems'
require 'open-uri'
require 'nokogiri'

# To use this, copy the src of
# 'https://developer.apple.com/ios/manage/devices/index.action' and save as a
# local index.html. All devices UUID in the page will be extracted. The
# extracted format is '<name><tab><uuid>', which is also the formatted required
# for import of UUIDs.

file = Nokogiri::HTML(open('index.html'))

puts "#This is an auto generated UDIDs list"

uuids = Array.new
uuids_name = Array.new

file.css('div.nt_multi table td.name span').each do |l|
   uuids_name.push(l.content)
end


file.css('div.nt_multi table td.id').each do |l|
   uuids.push(l.content)
end

if uuids.size != uuids_name.size
   puts "Error, invalid size #{uuids.size} and #{uuids_name.size}"
   exit
end

uuids.each_with_index do |u, index|
   puts "#{u}\t#{uuids_name[index]}"
end
