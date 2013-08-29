#!/usr/bin/env ruby

port = ARGV.shift or throw "need port"
interval = (ARGV.shift or '60').to_i

loop do
	sleep interval
	if `netstat -an | grep #{port} | wc -l`.to_i == 0
		puts 'end'
		exit
	end
end
