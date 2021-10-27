#!/usr/bin/perl

use strict;
use warnings;

my $data = "shwl_l1_twcd14}1ry4ht3neck_t3_bs{1c_hkh_tsh3he03gy_3l_hu";

my $flag = "#" x length($data);

my $from = -1;
while (my $line = <STDIN>)  {
	if ($line =~ /\.flag-char-([0-9]+) \{/) {
		$from = int($1);
	} elsif ($line =~ /order: ([0-9]+);/) {
		my $to = int($1);
		if ($from >= 0) {
			substr($flag, $to, 1) = substr($data, $from, 1);
		}
		$from = -1;
	}
}

print "$flag\n";
