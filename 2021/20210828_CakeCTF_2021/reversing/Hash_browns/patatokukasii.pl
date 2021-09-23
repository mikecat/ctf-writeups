#!/usr/bin/perl

use strict;
use warnings;

if (@ARGV < 2) {
	die "Usage: perl patatokukasii.pl patokaa takusii\n";
}

my $p = $ARGV[0];
my $t = $ARGV[1];

if (length($p) < length($t)) { $p .= "x" x (length($t) - length($p)); }
if (length($p) > length($t)) { $t .= "x" x (length($p) - length($t)); }

my $l = length($p);
for (my $i = 0; $i < $l; $i++) {
	print substr($p, $i, 1);
	print substr($t, $i, 1);
}
print "\n";
