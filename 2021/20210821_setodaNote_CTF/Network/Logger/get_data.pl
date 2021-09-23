#!/usr/bin/perl

use strict;
use warnings;

binmode(STDIN);
binmode(STDOUT);

my $data = "";
while (<STDIN>) { $data .= $_; }

my $start = 0;
my $key = "\x09\x00\x01\x02\x00\x01\x00\x81\x01\x08\x00\x00\x00";

for (;;) {
	my $next = index($data, $key, $start);
	if ($next < 0) { last; }
	print substr($data, $next + length($key), 8);
	$start = $next + 1;
}
