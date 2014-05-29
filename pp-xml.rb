#!/usr/bin/env ruby

require 'rexml/document'

REXML::Document.new($stdin.read).write($stdout, 2)

