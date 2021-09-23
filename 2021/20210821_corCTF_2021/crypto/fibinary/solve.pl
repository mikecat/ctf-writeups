#!/usr/bin/perl

use strict;
use warnings;

my @fib_cache = (1, 1);

sub fib {
	my $n = $_[0];
	if ($n < @fib_cache) { return $fib_cache[$n]; }
	for (my $i = @fib_cache; $i <= $n; $i++) {
		push(@fib_cache, $fib_cache[$i - 1] + $fib_cache[$i - 2]);
	}
	return $fib_cache[$n];
}

while (my $line = <STDIN>) {
	chomp($line);
	my @data = split(/\s+/, $line);
	for (my $i = 0; $i < @data; $i++) {
		my $res = 0;
		my $l = length($data[$i]);
		for (my $j = 0; $j < $l; $j++) {
			if (substr($data[$i], $j, 1) eq "1") {
				$res += &fib($l - $j - 1);
			}
		}
		print chr($res);
	}
}

print "\n";
