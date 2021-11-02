#!/usr/bin/perl

use strict;
use warnings;

my @data = ();

my $append = 0;
while (my $line = <STDIN>) {
	if (index($line, "append") >= 0) {
		$append = 1;
	} else {
		if ($append && $line =~ /\(([0-9]+)\)/) {
			push(@data, $1);
		}
		$append = 0;
	}
}

print "a = [";
print join(", ", @data);
print "]\n";
