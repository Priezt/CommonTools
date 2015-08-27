#!/usr/bin/env perl

for my $cmd (@ARGV){
	system("tmux split-window");
	system("tmux send-keys '".$cmd."'");
	system("tmux send-keys C-m");
}
