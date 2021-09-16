#!/usr/bin/perl

use strict;
use warnings;

my $chall = @ARGV > 0 ? $ARGV[0] : "nostrings/chall";

my $data = "";
open(CHALL, "< $chall") or die "failed to open chall\n";
binmode(CHALL);
while (<CHALL>) { $data .= $_; }
close(CHALL);

$data = substr($data, 0x3020);

my $ans = "";
for (my $i = 0; $i <= 0x39; $i++) {
	for (my $j = 0; $j < 256; $j++) {
		if (ord(substr($data, $j * 0x7f + $i, 1)) == $j) {
			$ans .= chr($j);
			last;
		}
	}
}

print "$ans\n";
