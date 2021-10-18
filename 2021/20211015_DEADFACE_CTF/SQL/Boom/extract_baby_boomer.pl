#!/usr/bin/perl

use strict;
use warnings;

my $data = "";
while (<STDIN>) { $data .= $_; }

my @datalist = split(/INSERT INTO|\),\(/, $data);
for (my $i = 0; $i < @datalist; $i++) {
	if ($datalist[$i] =~ /[0-9]{2}\/[0-9]{2}\/([0-9]{4})/) {
		my $y = int($1);
		if (1946 <= $y && $y <= 1964) {
			print "$datalist[$i]\n";
		}
	}
}
