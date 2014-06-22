#!/usr/bin/env ruby

# encoding: utf-8

require 'open-uri'
require 'nokogiri'
require 'uri'
require 'optparse'
require 'json'

url = ARGV.shift
item_selector = ARGV.shift

page = Nokogiri::HTML(open(url))

page.css(item_selector).each do |item|
	puts item.text.gsub(/[\s\r\n]+/, ' ')
end
