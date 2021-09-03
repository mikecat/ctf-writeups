#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;

my $sock = new IO::Socket::INET(PeerAddr=>"10.1.1.10", PeerPort=>12020, Proto=>"tcp");
die "failed to connect: $!\n" unless $sock;

while (my $line = <$sock>) {
	print $line;
	if ($line =~ /echo me: ([0-9]+)/) {
		print $sock "$1\n";
	}
}

close($sock);
