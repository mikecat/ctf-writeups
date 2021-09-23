#!/usr/bin/perl

use strict;
use warnings;

binmode(STDOUT);

while (my $line = <STDIN>) {
	chomp($line);
	if ($line =~ /#([0-9a-fA-F]+)/) {
		my $data = $1;
		if (length($data) < 16) {
			my $left = (16 - length($data)) >> 1;
			$data .= sprintf("8%d", $left) x $left;
		}
		for (my $i = 0; $i < 8; $i++) {
			print chr(hex(substr($data, $i * 2, 2)));
		}
	}
}
