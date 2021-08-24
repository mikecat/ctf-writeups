#!/usr/bin/perl

use strict;
use warnings;

use Crypt::Cipher::AES;

sub hex2data {
	my $d = $_[0];
	my $res = "";
	my $l = length($d);
	for (my $i = 0; $i < $l; $i += 2) {
		$res .= chr(hex(substr($d, $i, 2)));
	}
	return $res;
}

if (@ARGV < 1) { die "Usage: perl bruteforce.pl ciphertext_hex\n"; }

my $ciphertext = &hex2data($ARGV[0]);
my $ctlen = length($ciphertext);

while (my $line = <STDIN>) {
	chomp($line);
	my ($key, $iv) = split(/ /, $line);
	eval {
		my $c = Crypt::Cipher::AES->new(&hex2data($key));
		my $prev = &hex2data($iv);
		my $res = "";
		for (my $i = 0; $i < $ctlen; $i += 16) {
			my $block = substr($ciphertext, $i, 16);
			$res .= $c->decrypt($block) ^ $prev;
			$prev = $block;
		}
		print "$res\n";
	};
	if ($@) {
		my $mes = $@;
		chomp($mes);
		print "$mes\n";
	}
}
