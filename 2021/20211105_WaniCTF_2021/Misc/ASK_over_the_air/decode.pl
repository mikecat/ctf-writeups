#!/usr/bin/perl

use strict;
use warnings;

<STDIN>; # ignore header

my $tics = 6.36e-05;

my $offset = (@ARGV > 0 ? $ARGV[0] + 0.0 : 0);

my $current = 0;
my $start = 0;

my $all = 0;
my $yes = 0;
while (my $line = <STDIN>) {
	chomp($line);
	my ($t, $d1, $d2) = split(/ *, */, $line);
	if (int(($t - $offset) / $tics) != $current) {
		if ($yes > $all / 2) {
			print "1";
		} else {
			print "0";
		}
		$yes = 0;
		$all = 0;
		$current = int(($t - $offset) / $tics);
	}
	$all += 2;
	my $ad1 = abs($d1);
	my $ad2 = abs($d2);
	if (0.0014 < $ad1 && $ad1 < 0.0085) { $yes++; }
	if (0.0014 < $ad2 && $ad2 < 0.0085) { $yes++; }
}

if ($yes > $all / 2) {
	print "1\n";
} else {
	print "0\n";
}
