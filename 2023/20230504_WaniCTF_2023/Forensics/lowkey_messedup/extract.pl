#!/usr/bin/perl

use strict;
use warnings;

my $key = "\x81\xac\xff\xff";
my $offset = 0x15;
my $length = 8;

my $data = "";
binmode(STDIN);
while (<STDIN>) { $data .= $_; }

my $start = 0;
for (;;) {
	my $pos = index($data, $key, $start);
	if ($pos < 0 || $pos + $offset > length($data) - $length) { last; }
	my $extracted = substr($data, $pos + $offset, $length);
	for (my $i = 0; $i < $length; $i++) {
		if ($i > 0) { print " "; }
		printf "%02x", ord(substr($extracted, $i, 1));
	}
	print "\n";
	$start = $pos + 1;
}
