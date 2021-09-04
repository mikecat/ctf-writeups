#!/usr/bin/perl

use strict;
use warnings;

for (my $i = 1000; $i >= 1; $i--) {
	open(PASS, "pass.txt") or die "meow\n";
	my $pass = <PASS>;
	close(PASS);
	chomp($pass);
	print "$i : $pass\n";
	system("mv pass.txt pass$i.txt");
	system("unzip -P $pass flag$i.zip");
}
