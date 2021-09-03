#!/usr/bin/perl

use strict;
use warnings;

for (my $i = 1; $i <= 90; $i++) {
	system(sprintf("shasum -a 256 hash/pass%03d.txt", $i));
}
