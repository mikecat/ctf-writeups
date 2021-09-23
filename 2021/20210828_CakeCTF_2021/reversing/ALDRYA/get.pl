#!/usr/bin/perl

use strict;

if (@ARGV < 2) {
	die "perl get.pl file offset\n";
}

my $file = $ARGV[0];
my $offset = int($ARGV[1]);

my $data = "";
open(FILE, "< $file") or die "file open error\n";
binmode(FILE);
while (<FILE>) { $data .= $_; }
close(FILE);

my $value = 0x20210828;
for (my $i = 0; $i < 0x100; $i++) {
	my $c = ord(substr($data, $offset + $i, 1));
	$value = (($value ^ $c) >> 1) | ((($value ^ $c) & 1) << 0x1f);
}
printf "0x%x\n", $value;
