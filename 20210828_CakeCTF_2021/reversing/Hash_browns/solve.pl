#!/usr/bin/perl

use strict;
use warnings;

use Digest::MD5;
use Digest::SHA;

my %table = ();

for (my $i = 0x20; $i < 0x7f; $i++) {
	my $str = chr($i);
	my $md5 = Digest::MD5::md5_hex($str);
	my $sha = Digest::SHA::sha256_hex($str);
	$table{substr($md5, 0, 10)} = $str;
	$table{substr($sha, 0, 10)} = $str;
}

while (my $line = <STDIN>) {
	chomp($line);
	if (defined($table{$line})) {
		print $table{$line};
	}
}
print "\n";
