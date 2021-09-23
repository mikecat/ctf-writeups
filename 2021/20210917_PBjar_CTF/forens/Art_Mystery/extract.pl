#!/usr/bin/perl

use strict;
use warnings;

my $in_file = @ARGV > 0 ? $ARGV[0] : "Manipulated/corr.png";

open(IN, "< $in_file") or die("failed to open $in_file\n");
binmode(IN);
my $data = "";
while (<IN>) { $data .= $_; }
close(IN);

binmode(STDOUT);

my $pos = 8;
while ($pos < length($data)) {
	my $len = unpack("N", substr($data, $pos, 4));
	my $type = substr($data, $pos + 4, 4);
	print STDERR "$pos $len $type\n";
	if ($type eq "IDAT") {
		print substr($data, $pos + 8, $len);
	}
	$pos += $len + 12;
}
