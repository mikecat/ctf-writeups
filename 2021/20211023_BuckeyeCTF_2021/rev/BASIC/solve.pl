#!/usr/bin/perl

use strict;
use warnings;

my $str = "F4X67ENQPK0{MTJRHL}O3G59UB-ZAWV8S2YI1CD";
my @pos = (26,25,38,10,6,35,6,12,13,2,14,17,27,38,18,29,23,23,27,30,2,33,27,26,11,16,37,7,22,19);

for (my $i = 0; $i < @pos; $i++) {
	print substr($str, $pos[$i] - 1, 1);
}
print "\n";
