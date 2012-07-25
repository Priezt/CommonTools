#!/usr/bin/env perl

use Digest::MD5 qw /md5_hex/;

$category = shift @ARGV || 'default';
if($category =~ /^-/){
	$category =~s /^-//;
	$directory = $ENV{HOME}."/.fresh/".$category;
	system('rm -f '.$directory."/*");
	exit;
}
$directory = $ENV{HOME}."/.fresh/".$category;

unless(-d $dir){
	system("mkdir -p '$directory'");
}

while(<STDIN>){
	chomp;
	next if /^\s*$/;
	$md5 = md5_hex($_);
	next if -f $directory."/".$md5;
	system("touch '$directory/$md5'");
	print;
	print "\n";
}
