#!/usr/bin/env ruby

require 'open-uri'
require 'nokogiri'

url = ARGV[0]
selector = ARGV[1]

page = Nokogiri::HTML(open(url))
page.css(selector).each do |a|
	puts "#{url}|#{a.text}".gsub /\s+/, ' '
end
