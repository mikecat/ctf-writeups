#!/usr/bin/perl

use strict;
use warnings;

my $prefix = "challenges.2021.squarectf.com+5001/pubkeys/";

for (my $i = 0; $i <= 511; $i++) {
	system(sprintf("perl zatu_ni_toridasu.pl < \"%su%04d.pub\"", $prefix, $i));
}
