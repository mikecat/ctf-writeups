#!/usr/bin/perl

use strict;
use warnings;

my $value = 0xc42bfd0c;

for (my $i = 0; $i < 16; $i++) {
	printf "%08x", $value;
	$value = ($value * 0x17433a5b + -0x481e7b5d) & 0xffffffff;
}

print "\n";
