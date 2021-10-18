#!/usr/bin/perl

use strict;
use warnings;

my $data = "";
while (<STDIN>) { $data .= $_; }

my @datalist = split(/INSERT INTO|,\(/, $data);
for (my $i = 0; $i < @datalist; $i++) {
	if ($datalist[$i] =~ /^([0-9]+),[^)]*,'El Paso',/) {
		print "$1\n";
	}
}
