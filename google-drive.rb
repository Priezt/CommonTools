#!/usr/bin/env ruby

require 'google_drive'
require 'highline/import'

$session = nil
$email = nil
$local_file = nil
$remote_file = nil
$cmd = nil

def print_help
	puts 'Usage:'
	puts "\t google-drive.rb email upload localfile remotefile [-d foldername]"
	puts "\t google-drive.rb email download remotefile localfile"
	puts "\t google-drive.rb email list foldername [-u]"
	puts "\t google-drive.rb email mirror foldername localfolder"
	exit
end

def get_gmail_pass
	if ENV['GMAIL_PASS']
		return ENV['GMAIL_PASS']
	else
		return ask("Password: "){|q| q.echo = false}
	end
end

def login
	$session = GoogleDrive.login($email, get_gmail_pass)
end

if ARGV.length < 2
	print_help
end

$email = ARGV[0]
$cmd = ARGV[1]

case $cmd
	when 'upload'
		login
		$local_file = ARGV[2]
		$remote_file = ARGV[3]
		file = $session.upload_from_file($local_file, $remote_file, :convert => false)
		if ARGV[4] == '-d'
			collection = $session.collection_by_title(ARGV[5])
			if collection
				collection.add(file)
			else
				puts 'No such collection: ' + ARGV[5]
			end
		end
	when 'download'
		login
		$local_file = ARGV[3]
		$remote_file = ARGV[2]
		file = $session.file_by_title($remote_file)
		if file
			file.download_to_file($local_file)
		else
			puts 'File not found: ' + $remote_file
		end
	when 'list'
		login
		collection = $session.collection_by_title(ARGV[2])
		if collection
			collection.files.each{
				|f|
				if ARGV[3] == '-u'
					puts f.title + '|' + f.document_feed_url
				else
					puts f.title
				end
			}
		else
			puts 'No such collection: ' + ARGV[2]
		end
	when 'mirror'
		login
		collection = $session.collection_by_title(ARGV[2])
		target_dir = ARGV[3]
		if collection
			system('mkdir -p ' + target_dir)
			collection.files.each{
				|f|
				puts f.title
				f.download_to_file(target_dir + '/' + f.title)
				
			}
		else
			puts 'No such collection: ' + ARGV[2]
		end
	else
		puts 'No such command: ' + $cmd
end


