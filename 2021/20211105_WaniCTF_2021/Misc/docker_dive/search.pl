#!/usr/bin/perl

use strict;
use warnings;

my $ct = "72386554483c7006407f1a14446c0d700440401b7b5456311f4271401b7b245b201f3770571f41414e";

my @ct_dec = ();
for (my $i = 0; $i < length($ct); $i += 2) {
	push(@ct_dec, hex(substr($ct, $i, 2)));
}

sub is_good_char {
	my $c = $_[0];
	if (ord("a") <= $c && $c <= ord("z")) { return 1; }
	if (ord("A") <= $c && $c <= ord("Z")) { return 1; }
	if (ord("0") <= $c && $c <= ord("9")) { return 1; }
	if ($c == ord("_")) { return 1; }
	return 0;
}

for (my $i = 5; $i < 9; $i++) {
	print "$i:";
	for (my $j = 0; $j < 0x100; $j++) {
		my $yes = 1;
		for(my $k = $i; $k < @ct_dec; $k += 9) {
			my $v = $ct_dec[$k] ^ $j;
			unless (&is_good_char($v)) {
				$yes = 0;
				last;
			}
		}
		#if ($yes) { printf " %02x", $j; }
		if ($yes) { printf " %c", $ct_dec[$i] ^ $j; }
	}
	print "\n";
}
