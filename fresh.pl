#!/usr/bin/env perl

use Digest::MD5 qw /md5_hex/;

$category = shift @ARGV || 'default';
if($category =~ /^-/){
	$category =~s /^-//;
	$directory = $ENV{HOME}."/.fresh/".$category;
	system('rm -f '.$directory."/*");
	exit;
}

unless(-d $ENV{HOME}."/.fresh"){
	system("mkdir -p '".$ENV{HOME}."/.fresh'");
}

$target = $ENV{HOME}."/.fresh/".$category;

unless(-e $target){
	system("touch '$target'");
}

$added = 0;
$md5_map = {};

sub md5_load{
	if(-f $target){
		open F,"<",$target;
		while(<F>){
			chomp;
			next if length($_) == 0;
			$md5_map->{$_} = 1;
		}
		close F;
	}else{
		my @files = split /[\r\n]+/, `ls $target`;
		for(@files){
			next if length($_) == 0;
			s/.*\///;
			$md5_map->{$_} = 1;
		}
	}
}

sub md5_exists{
	my $k = shift;
	return $md5_map->{$k};
}

sub md5_add{
	my $k = shift;
	$md5_map->{$k} = 1;
	$added = 1;
}

sub md5_update{
	if(-d $target){
		system("rm -rf '$target'");
	}
	open F,">",$target;
	for(keys %$md5_map){
		print F $_."\n";
	}
	close F;
}

md5_load();

while(<STDIN>){
	chomp;
	next if /^\s*$/;
	my $line = $_;
	$md5 = md5_hex($_);
	next if md5_exists($md5);
	md5_add($md5);
	print $line;
	print "\n";
}

if($added){
	md5_update();
}
