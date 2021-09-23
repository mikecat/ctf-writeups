#!/usr/bin/perl

use strict;
use warnings;

my $filename = @ARGV > 0 ? $ARGV[0] : "rgb.txt";

my @data = ();
open(DATA, "< $filename") or die "failed to open data\n";
while (my $line = <DATA>) {
	chomp($line);
	my @lsp = split(/\s+/, $line);
	for (my $i = 0; $i < @lsp; $i++) {
		push(@data, int($lsp[$i]) & 1);
	}
}

for (my $assume_len = 9; $assume_len < 256; $assume_len++) {
	my @flag = ();
	for (my $i = 0; $i < $assume_len; $i++) { push(@flag, 0xff); }
	for (my $i = 0; $i < @data; $i++) {
		unless ($data[$i]) {
			my $idx = $i % ($assume_len * 8 - 1);
			my $idx_byte = $idx >> 3;
			my $idx_bit = $idx & 7;
			$flag[$idx_byte] &= ~(1 << $idx_bit);
		}
	}
	my $flag_str = "";
	for (my $i = 0; $i < @flag; $i++) { $flag_str .= chr($flag[$i]); }
	print "$flag_str\n";
}
