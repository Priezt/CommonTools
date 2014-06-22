#!/usr/bin/env ruby

# encoding: utf-8

require 'open-uri'
require 'nokogiri'
require 'uri'
require 'optparse'
require 'json'

url = ARGV.shift
img_selector = ARGV.shift

page = Nokogiri::HTML(open(url))

page.css(img_selector).each do |img|
	puts URI.join(url, img.attr("src"))
end
