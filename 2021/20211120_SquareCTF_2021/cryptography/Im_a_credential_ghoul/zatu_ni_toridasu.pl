#!/usr/bin/perl

use strict;
use warnings;

use MIME::Base64;

my $data = "";
while (<STDIN>) { $data .= $_; }

$data =~ s/-----.*?-----//g;
$data =~ s/[\r\n]//g;

my $bindata = MIME::Base64::decode_base64($data);
my $blen = length($bindata);

my $res = "0x";
for (my $i = 0x20; $i < $blen - 5; $i++) {
	$res .= sprintf("%02x", ord(substr($bindata, $i, 1)));
}

print "$res\n";
