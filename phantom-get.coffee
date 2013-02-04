#!/usr/bin/env phantomjs

system = require 'system'

if system.args.length < 2
	console.log 'need url'
	phantom.exit()

url = system.args[1]

page = require('webpage').create()

page.open url, (status) ->
	console.log page.content
	phantom.exit()
