#!/usr/bin/env perl

$lib = shift @ARGV;

eval("use $lib;");

$lib =~s /::/\//g;
print $INC{$lib.".pm"}."\n";
