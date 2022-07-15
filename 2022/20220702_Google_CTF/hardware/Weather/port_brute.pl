#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket;

unless (@ARGV == 2) {
	die "Usage: port_brute.pl host port\n";
}

my $sock = new IO::Socket::INET(PeerAddr=>$ARGV[0], PeerPort=>int($ARGV[1]), Proto=>"tcp");
unless ($sock) { die "connect error\n"; }

for (my $i = 0; $i < 128; $i++) {
	print $sock sprintf("r 101248%03d 1\n", $i);
	for (;;) {
		my $line = <$sock>;
		unless ($line) { die "communication error\n"; }
		chomp($line);
		if (index($line, "i2c") >= 0) {
			printf "%3d: %s\n", $i, $line;
			last;
		}
	}
}

close($sock);
