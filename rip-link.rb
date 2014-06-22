#!/usr/bin/env ruby

# encoding: utf-8

require 'open-uri'
require 'nokogiri'
require 'uri'
require 'optparse'
require 'json'

url = ARGV.shift
link_selector = ARGV.shift

page = Nokogiri::HTML(open(url))

page.css(link_selector).each do |link|
	puts URI.join(url, link.attr("href"))
end
