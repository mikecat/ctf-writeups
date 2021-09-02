#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;

if (@ARGV < 2) {
	die "Usage: solve.pl host port\n";
}

my $sock = new IO::Socket::INET(PeerAddr=>$ARGV[0], PeerPort=>int($ARGV[1]), Proto=>"tcp");
die "failed to connect: $!\n" unless $sock;

my $ciphertext = <$sock>;
chomp($ciphertext);
my $clen = length($ciphertext);

sub sendQuery {
	my $q = $_[0];
	print $sock "$q\n";
	my $res = <$sock>;
	if ($res =~ /([01])/) {
		return int($1);
	} else {
		return 0;
	}
}

sub toHex {
	my $q = $_[0];
	my $res = "";
	my $l = length($q);
	for (my $i = 0; $i < $l; $i++) {
		$res .= sprintf("%02X", ord(substr($q, $i, 1)));
	}
	return $res;
}

my $iv = substr($ciphertext, 0, 32);

print "iv : $iv\n";
printf "ct : %s\n", substr($ciphertext, 32);
print "key:\n";

for (my $i = 32; $i + 32 <= $clen; $i += 32) {
	my $header = substr($ciphertext, 0, $i);
	my $foundKey = "";
	for (my $j = 1; $j <= 16; $j++) {
		my $header2 = &toHex("\0" x (16 - $j));
		my $footer = $j == 1 ? "" : &toHex($foundKey ^ (chr($j) x ($j - 1)));
		my $found = -1;
		for (my $k = 0; $k < 256; $k++) {
			my $query = $header . $header2 . sprintf("%02X", $k) . $footer;
			if (&sendQuery($query)) {
				$found = $k;
				last;
			}
		}
		if ($found >= 0) {
			$foundKey = chr($found ^ $j) . $foundKey;
			print STDERR ".";
		} else {
			die "not found\n";
		}
	}
	print STDERR "\n";
	printf "%s\n", &toHex($foundKey);
}

close($sock);
