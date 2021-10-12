#!/usr/bin/perl

use strict;
use warnings;

binmode(STDIN);
my $data = "";
while (<STDIN>) { $data .= $_; }

my $key = "\xd3\x0a\xe4\xe9";

my $result = "";
my $pos = 0;
for (;;) {
	my $find = index($data, $key, $pos);
	if ($find < 0 || length($data) - 11 < $find) { last; }
	if (substr($data, $find + 10, 1) eq "\x16") {
		my $length = unpack("S", substr($data, $find + 6, 2));
		my $offset = unpack("S", substr($data, $find + 13, 2));
		my $data = substr($data, $find + 15, $length - 2 - 3);
		if (length($result) < $offset) { $result .= "#" x ($offset - length($result)); }
		substr($result, $offset, length($data)) = $data;
		printf "%d\t%s\n", $offset, $data;
	}
	$pos = $find + 1;
}
print "$result\n";
