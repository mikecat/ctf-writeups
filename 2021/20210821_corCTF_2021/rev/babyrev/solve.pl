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

my @target_raw = split(/ /, "5F 40 5A 15 75 45 62 53 75 46 52 43 5F 75 50 52 75 5F 5C 4F");
my @target = ();
for (my $i = 0; $i < @target_raw; $i++) {
	push(@target, hex($target_raw[$i]) ^ 42);
}

my $sa = ord("a");
my $la = ord("A");

print "corctf{";
for (my $i = 0; $i < @target; $i++) {
	my $p = $i * 4;
	until (&is_prime($p)) { $p++; }
	if ($sa <= $target[$i] && $target[$i] < $sa + 26) {
		print chr((($target[$i] - $sa) - $p % 26 + 26) % 26 + $sa);
	} elsif ($la <= $target[$i] && $target[$i] < $la + 26) {
		print chr((($target[$i] - $la) - $p % 26 + 26) % 26 + $la);
	} else {
		print chr($target[$i]);
	}
}
print "}\n";
