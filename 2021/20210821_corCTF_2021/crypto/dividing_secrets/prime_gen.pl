#!/usr/bin/perl

use strict;
use warnings;

sub is_prime {
	my $a = $_[0];
	if ($a < 2) { return 0; }
	for (my $i = 2; $i * $i <= $a; $i++) {
		if ($a % $i == 0) { return 0; }
	}
	return 1;
}

my $p = @ARGV < 1 ? 100 : int($ARGV[0]);

for (my $i = 0; $i < 64; $i++) {
	until (&is_prime($p)) { $p++; }
	print "$p\n";
	$p++;
}
