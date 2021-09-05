#!/usr/bin/perl

use strict;
use warnings;

if (@ARGV < 2) {
	die "Usage: perl file_diff.pl modified_file original_file\n";
}

my $modified = "";
my $original = "";

open(MOD, "< $ARGV[0]") or die "failed to open $ARGV[0]\n";
binmode(MOD);
while (<MOD>) { $modified .= $_; }
close(MOD);

open(ORIG, "< $ARGV[1]") or die "failed to open $ARGV[1]\n";
binmode(ORIG);
while (<ORIG>) { $original .= $_; }
close(ORIG);

my $len_mod = length($modified);
my $len_orig = length($original);

for (my $i = 0; $i < $len_mod && $i < $len_orig; $i++) {
	my $m = substr($modified, $i, 1);
	my $o = substr($original, $i, 1);
	if ($m ne $o) { print $m; }
}
