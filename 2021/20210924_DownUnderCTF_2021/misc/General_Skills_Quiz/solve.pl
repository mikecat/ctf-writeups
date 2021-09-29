#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;

use URI::Escape;
use MIME::Base64;

if (@ARGV != 2) {
	use File::Basename;
	my $name = basename($0, "");
	die "Usage: perl $name host port\n";
}

my $sock = new IO::Socket::INET(PeerAddr=>$ARGV[0], PeerPort=>int($ARGV[1]), Proto=>"tcp");
unless ($sock) { die "connection failed: $!\n"; }
binmode($sock);

print $sock "\n";
print $sock "2\n";

sub rot13 {
	my $in = $_[0];
	my $ba = ord("A");
	my $sa = ord("a");
	my $out = "";
	my $len = length($in);
	for (my $i = 0; $i < $len; $i++) {
		my $c = substr($in, $i, 1);
		my $o = ord($c);
		if ($ba <= $o && $o < $ba + 26) {
			$out .= chr(($o - $ba + 13) % 26 + $ba);
		} elsif ($sa <= $o && $o < $sa + 26) {
			$out .= chr(($o - $sa + 13) % 26 + $sa);
		} else {
			$out .= $c;
		}
	}
	return $out;
}

while (my $line = <$sock>) {
	print $line;
	if ($line =~ /hex.*\(base 10\): 0x([0-9a-f]+)/) {
		print $sock (hex($1) . "\n");
	} elsif ($line =~ /ASCII letter: ([0-9a-f]+)/) {
		print $sock sprintf("%c\n", hex($1));
	} elsif ($line =~ /ASCII symbols: (.*)/) {
		print $sock (uri_unescape($1) . "\n");
	} elsif ($line =~ /base64.*plaintext: (.*)/) {
		print $sock (MIME::Base64::decode_base64($1) . "\n");
	} elsif ($line =~ /Base64: (.*)/) {
		print $sock (MIME::Base64::encode_base64($1, "") . "\n");
	} elsif ($line =~ /rot13.*: (.*)/i) {
		print $sock (&rot13($1) . "\n");
	} elsif ($line =~ /binary.*\(base 10\): (0b[01]+)/) {
		print $sock (oct($1) . "\n");
	} elsif ($line =~ /binary equivalent: ([0-9]+)/) {
		print $sock sprintf("0b%b\n", int($1));
	} elsif ($line =~ /universe/) {
		#print $sock "DownUnderCTF\n";
		#print $sock "DownUnderCTF 2021\n";
		print $sock "DUCTF\n";
	}
}
