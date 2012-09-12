#!/usr/bin/env ruby

puts "Crushing images"
count = 0

relative_path = "/images"

directory = File.join(Dir.pwd, relative_path)
puts "Path: #{directory}"

Dir.foreach(directory) do |file|
   fullpath = File.join(directory, file)
   `xcrun -sdk iphoneos pngcrush -iphone "#{fullpath}" "#{fullpath}_crushed"`
   `mv "#{fullpath}_crushed" "#{fullpath}"`
   count = count + 1
end
puts "Crushed #{count} images"
