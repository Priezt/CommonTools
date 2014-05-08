#!/usr/bin/env ruby

require 'open-uri'
require 'nokogiri'
require 'uri'
require 'optparse'

params = ARGV.getopts("u:")

url = ARGV[0]
selector = ARGV[1]

if url =~ /^http/
	page = Nokogiri::HTML(open(url))
else
	page = Nokogiri::HTML(File.open(url))
	url = params["u"] || raise("need -u")
end

page.css(selector).each do |a|
	if a.name == "a"
		puts "#{URI.join url, a.attr("href")}|#{a.text}".gsub /\s+/, ' '
	else
		puts "#{url}|#{a.text}".gsub /\s+/, ' '
	end
end
