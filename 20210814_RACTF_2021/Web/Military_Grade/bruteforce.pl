#!/usr/bin/perl

use strict;
use warnings;

use Crypt::Mode::CBC;

sub hex2data {
	my $d = $_[0];
	my $res = "";
	my $l = length($d);
	for (my $i = 0; $i < $l; $i += 2) {
		$res .= chr(hex(substr($d, $i, 2)));
	}
	return $res;
}

my $ciphertext = &hex2data("48d7270865f49a43524aec5b3d84661444707de824881f26f66c171c025196dc");

my $cbc = Crypt::Mode::CBC->new('AES');

while (my $line = <STDIN>) {
	chomp($line);
	my ($key, $iv) = split(/ /, $line);
	eval {
		my $res = $cbc->decrypt($ciphertext, &hex2data($key), &hex2data($iv));
		print "$res\n";
	};
	if ($@) {
		my $mes = $@;
		chomp($mes);
		print "$mes\n";
	}
}
