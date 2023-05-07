#!/usr/bin/perl

use strict;
use warnings;

if (@ARGV < 1) {
	warn "Usage: ./decode.pl <keyboard.cpp path>\n";
	exit 1;
}

my @keycode_map = ();
my @keycode_map_shifted = ();

my $mode = 0;
open(KEYBOARD, "< $ARGV[0]") or die;
while (my $line = <KEYBOARD>) {
	if ($mode == 0) {
		if (index($line, "keycode_map_shifted") >= 0) { $mode = 2; }
		elsif (index($line, "keycode_map") >= 0) { $mode = 1; }
	} else {
		$line =~ s/\/\/.*$//;
		my @line_data = split(/,/, $line);
		for (my $i = 0; $i < @line_data - 1; $i++) {
			my $element = $line_data[$i];
			$element =~ s/^\s+//;
			$element =~ s/\s+$//;
			if ($mode == 1) { push(@keycode_map, $element); }
			elsif ($mode == 2) { push(@keycode_map_shifted, $element); }
		}
		if (index($line, "};") >= 0) { $mode = 0; }
	}
}
close(KEYBOARD);

while (my $line = <STDIN>) {
	chomp($line);
	my @line_data = split(/\s+/, $line);
	my @line_values = ();
	for (my $i = 0; $i < @line_data; $i++) {
		push(@line_values, hex($line_data[$i]));
	}
	if (@line_values == 8 && $line_values[1] == 0) {
		my $shifted = $line_values[0] & 0x22;
		my $first = 1;
		for (my $i = 2; $i < 8; $i++) {
			if ($line_values[$i] != 0) {
				unless ($first) { print " "; }
				if ($shifted) {
					print $keycode_map_shifted[$line_values[$i]];
				} else {
					print $keycode_map[$line_values[$i]];
				}
				$first = 0;
			}
		}
		unless ($first) { print "\n"; }
	}
}
