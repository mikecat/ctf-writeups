#!/usr/bin/perl

use strict;
use warnings;

if (@ARGV < 1) {
	die "please specify which byte to extract\n";
}
my $target = int($ARGV[0]);

my @res = ();
for (my $i = 0; $i < 256 * 8; $i++) {
	push(@res, 0);
}

binmode(STDIN);
binmode(STDOUT);

my $data = "";
while (<STDIN>) { $data .= $_; }

my $dlen = length($data);
for (my $i = $target; $i < $dlen; $i += 8) {
	print substr($data, $i, 1);
}
