#!/usr/bin/perl

use strict;
use warnings;

binmode(STDIN);
my $data = "";
while (<STDIN>) { $data .= $_; }

my $pos = 0;
for (;;) {
	my $nextPos = index($data, "PK\x05\x06", $pos + 1);
	if ($nextPos < 0) { last; }
	my $offset = unpack("L", substr($data, $nextPos + 16, 4));
	print substr($data, $offset - 1, 1);
	$pos = $nextPos;
}
