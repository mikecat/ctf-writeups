#!/usr/bin/perl

use strict;
use warnings;

if (@ARGV != 1) {
	use File::Basename;
	my $name = basename($0, "");
	die "Usage: perl $name el_paso_id_list\n";
}

my %idlist = ();
open(LIST, "< $ARGV[0]") or die "failed to open $ARGV[0]\n";
while (<LIST>) {
	$idlist{int($_)} = 1;
}
close(LIST);

my $data = "";
while (<STDIN>) { $data .= $_; }

my @datalist = split(/INSERT INTO|\),\(/, $data);
for (my $i = 0; $i < @datalist; $i++) {
	if ($datalist[$i] =~ /^[0-9]+,[0-9]+,([0-9]+),([0-9]+\.[0-9]{2}),([0-9]+\.[0-9]{2}),([0-9]+\.[0-9]{2})/) {
		if (defined($idlist{int($1)})) {
			print "$2\t$3\t$4\n";
		}
	}
}
