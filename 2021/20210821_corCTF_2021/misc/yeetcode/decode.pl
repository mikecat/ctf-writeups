#!/usr/bin/perl

use strict;
use warnings;

<STDIN>; # ignore header

while (my $line = <STDIN>) {
	chomp($line);
	my @data = split(/\s+/, $line);
	print chr(int($data[2]) * 10 + int($data[1]) + 0x20);
}

print "\n";
