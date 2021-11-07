#!/usr/bin/perl

use strict;
use warnings;

my $data = "";
while (<STDIN>) { $data .= $_; }

my $data2 = "";
if ($data =~ /\(\("\{(.*)\)\)/s) {
	$data2 = $1;
} else {
	die "data not found\n";
}

my ($order, $parts) = split(/\}"-f '/, $data2);

my @order_list = split(/\}\{/, $order);
my @parts_list = split(/','/, $parts);

print STDERR sprintf("# of order = %d\n", @order_list + 0);
print STDERR sprintf("# of parts = %d\n", @parts_list + 0);

for (my $i = 0; $i < @order_list; $i++) {
	print $parts_list[$order_list[$i]];
}
