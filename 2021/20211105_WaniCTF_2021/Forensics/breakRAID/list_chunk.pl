#!/usr/bin/perl

use strict;
use warnings;

my $data = "";
binmode(STDIN);
while (<STDIN>) { $data .= $_; }

my @targets = ("IHDR", "IDAT", "IEND");

my $start = 0;
for (;;) {
	my $next = -1;
	for (my $i = 0; $i < @targets; $i++) {
		my $cnext = index($data, $targets[$i], $start);
		if ($cnext >= 0) {
			if ($next < 0 || $cnext < $next) {
				$next = $cnext;
			}
		}
	}
	if ($next < 0) { last; }
	my $len = unpack("N", substr($data, $next - 4, 4));
	my $name = substr($data, $next, 4);
	my $crc = unpack("N", substr($data, $next + 4 + $len, 4));
	printf "%08x\t%s\t%08x\t%08x\n", $next, $name, $len, $crc;
	$start = $next + 1;
}
