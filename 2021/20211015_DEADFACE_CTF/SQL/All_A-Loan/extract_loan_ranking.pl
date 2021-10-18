#!/usr/bin/perl

use strict;
use warnings;

if (@ARGV != 1) {
	use File::Basename;
	my $name = basename($0, "");
	die "Usage: perl $name california_list\n";
}

my %idlist = ();
open(LIST, "< $ARGV[0]") or die "failed to open $ARGV[0]\n";
while (<LIST>) {
	my ($id, $city) = split(/\t/, $_);
	chomp($city);
	$idlist{int($id)} = $city;
}
close(LIST);

my $data = "";
while (<STDIN>) { $data .= $_; }

my $type_small_business = 3;

my %balance_by_city = ();

my @datalist = split(/INSERT INTO|\),\(/, $data);
for (my $i = 0; $i < @datalist; $i++) {
	if ($datalist[$i] =~ /^[0-9]+,[0-9]+,([0-9]+),[0-9]+\.[0-9]{2},([0-9]+)\.([0-9]{2}),[0-9]+\.[0-9]{2},([0-9]+)/) {
		my $employee = int($1);
		my $amount = int($2) * 100 + int($3);
		my $type = int($4);
		my $city = $idlist{$employee};
		if (defined($city) && $type == $type_small_business) {
			if (defined($balance_by_city{$city})) {
				$balance_by_city{$city} += $amount;
			} else {
				$balance_by_city{$city} = $amount;
			}
		}
	}
}

my @balance_list = ();
my @balance_keys = keys(%balance_by_city);
for (my $i = 0; $i < @balance_keys; $i++) {
	push(@balance_list, sprintf("%s\t%s", $balance_keys[$i], $balance_by_city{$balance_keys[$i]}));
}

my @balance_list_sorted = sort {
	my ($a1, $a2) = split(/\t/, $a, 2);
	my ($b1, $b2) = split(/\t/, $b, 2);
	return $b2 <=> $a2;
} @balance_list;

for (my $i = 0; $i < @balance_list_sorted; $i++) {
	my ($city, $balance_raw) = split(/\t/, $balance_list_sorted[$i]);
	if (length($balance_raw) < 3) { $balance_raw = ("0" x (3 - length($balance_raw))) . $balance_raw; }
	my $len = length($balance_raw);
	printf "%s\t%s.%s\n", $city, substr($balance_raw, 0, $len - 2), substr($balance_raw, $len - 2);
}
