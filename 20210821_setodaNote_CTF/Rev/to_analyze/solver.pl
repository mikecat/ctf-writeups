#!/usr/bin/perl

use strict;
use warnings;

my @array1 = (
	65,
	127,
	89,
	80,
	182,
	160,
	183,
	182,
	89,
	118,
	119,
	116,
	177,
	189,
	177
);

my @array2 = (
	9,
	37,
	48,
	34,
	41,
	61,
	199,
	49,
	220,
	63,
	115,
	59,
	220,
	200,
	46,
	115,
	57,
	220,
	214,
	50,
	53,
	46,
	47,
	37,
	124,
	62,
	9
);

my @first_arr = ();
my $first_str = "";

for (my $i = 0; $i < @array1; $i++) {
	my $v = $array1[$i];
	$v ^= 35;
	if ($v == 107 || $v == 117 || $v == 108 || $v == 102 || $v == 98) {
		$v += 3;
	}
	$v ^= 21;
	$v -= 32;
	$v ^= 19;
	push(@first_arr, $v);
	$first_str .= chr($v);
}

print "$first_str\n";

my $second_str = "";

for (my $i = 0; $i < @array2; $i++) {
	my $v = $array2[$i];
	$v ^= $first_arr[12];
	$v ^= $first_arr[8];
	$v ^= $first_arr[3];
	$v ^=35;
	if ($v == 110 || $v == 119 || $v == 99 || $v == 111 || $v == 97 || $v == 101 || $v == 112 || $v == 103 || $v == 108 || $v == 107 || $v == 112 || $v == 113) {
		$v += 3;
	}
	$v ^= 21;
	$v -= 32;
	$v ^= 40;
	$second_str .= chr($v);
}

print "$second_str\n";
