#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;

my $sock = new IO::Socket::INET(PeerAddr=>"10.1.1.10", PeerPort=>12010, Proto=>"tcp");
die "failed to connect: $!\n" unless $sock;

while (my $line = <$sock>) {
	print $line;
	if ($line =~ /([0-9]+) \+ ([0-9]+)/) {
		my$ sum = int($1) + int($2);
		print $sock "$sum\n";
	} elsif ($line =~ /([0-9]+) - ([0-9]+)/) {
		my$ sum = int($1) - int($2);
		print $sock "$sum\n";
	}
}

close($sock);
