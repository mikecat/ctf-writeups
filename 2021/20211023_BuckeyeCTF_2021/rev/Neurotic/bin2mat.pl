#!/usr/bin/perl

use strict;
use warnings;

my $data = "";
binmode(STDIN);
while (<STDIN>) { $data .=$_; }

my $rows = 8;
my $cols = 8;

if (length($data) < 4 * $rows * $cols) { die "insufficient data\n"; }

print "{\n";
for (my $i = 0; $i < $rows; $i++) {
	printf "\t{%.32g", unpack("f", substr($data, 4 * $i * $cols));
	for (my $j = 1; $j < $cols; $j++) {
		printf ", %.32g", unpack("f", substr($data, 4 * ($i * $cols + $j)));
	}
	print "}";
	if ($i + 1 < $rows) { print ","; }
	print "\n";
}
print "}\n";
