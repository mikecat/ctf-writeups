#!/usr/bin/perl

use strict;
use warnings;

my @res = ();
for (my $i = 0; $i < 256 * 8; $i++) {
	push(@res, 0);
}

binmode(STDIN);

my $data = "";
while (<STDIN>) { $data .= $_; }

my $dlen = length($data);
my @allCount = (0, 0, 0, 0, 0, 0, 0, 0);
for (my $i = 0; $i < $dlen; $i++) {
	$res[($i % 8) * 256 + ord(substr($data, $i, 1))]++;
	$allCount[$i % 8]++;
}

for (my $i = 0; $i < 256; $i++) {
	printf "0x%02x %c |", $i, 0x20 <= $i && $i < 0x7f ? $i : 0x20;
	for (my $j = 0; $j < 8; $j++) {
		printf "%6d %5.2f%%|", $res[$j * 256 + $i], $res[$j * 256 + $i] / $allCount[$j] * 100;
	}
	print "\n";
}
