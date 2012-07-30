#!/usr/bin/env ruby

require 'google_drive'
require 'highline/import'

if ARGV.length != 3
	puts 'Usage:'
	puts "\t google-drive.rb upload /path/to/file name@gmail.com/filename"
	puts "\t google-drive.rb download name@gmail.com/filename /path/to/file"
	exit
end

if ARGV[0] == 'upload'
	local_file = ARGV[1]
	remote_file = ARGV[2]
elsif ARGV[0] == 'download'
	local_file = ARGV[2]
	remote_file = ARGV[1]
else
	die 'either upload or download'
end

unless remote_file =~ /^(.+)\/(.+)$/
	die 'remote file format wrong'
end

email = $1
remote_file = $2

password = ask("Password: "){|q| q.echo = false}

session = GoogleDrive.login(email, password)

if ARGV[0] == 'upload'
	session.upload_from_file(local_file, remote_file, :convert => false)
else
	file = session.file_by_title(remote_file)
	file.download_to_file(local_file)
end

