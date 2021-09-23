#!/usr/bin/perl

use strict;
use warnings;

binmode(STDIN);
binmode(STDOUT);

my $data = "";
while (<STDIN>) { $data .= $_; }

my $start = 0;
my $key = "\xc0\xcc\x0d\x66\xc5\x98\xff\xff\x43";

for (;;) {
	my $next = index($data, $key, $start);
	if ($next < 0) { last; }
	print substr($data, $next + 0x40, 8);
	$start = $next + 1;
}
