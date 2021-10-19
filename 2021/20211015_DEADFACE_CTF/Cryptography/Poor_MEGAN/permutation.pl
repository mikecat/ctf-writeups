#!/usr/bin/perl

use strict;
use warnings;

use MIME::Base64;

my $target = "j2rXjx9dkhW9eLKsnMR9cLDVjh/9dwz1QfGXm+b9=wKslL1Zpb45";

my $len = length($target);

for (my $i = 0; $i < $len; $i++) {
	if (substr($target, $i, 1) eq "=") { next; }
	for (my $j = 0; $j < $len; $j++) {
		if (substr($target, $j, 1) eq "=") { next; }
		if ($i == $j) { next; }
		for (my $k = 0; $k < $len; $k++) {
			if (substr($target, $k, 1) eq "=") { next; }
			if ($i == $k || $j == $k) { next; }
			for (my $l = 0; $l < $len; $l++) {
				if ($i == $l || $j == $l || $k == $l) { next; }
				my $test = substr($target, $i, 1) . substr($target, $j, 1) . substr($target, $k, 1) . substr($target, $l, 1);
				my $decoded = decode_base64($test);
				if ($decoded =~ /\A[\x20-\x7e]+\z/) {
					print "$test\t$decoded\n";
				}
			}
		}
	}
}
