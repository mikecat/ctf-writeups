#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket;

if (@ARGV != 2) {
	warn "Usage: ./solve.pl host port\n";
	exit 1;
}

my $sock = new IO::Socket::INET(PeerAddr=>$ARGV[0], PeerPort=>int($ARGV[1]), Proto=>"tcp");
die "connect failed: $!\n" unless $sock;

my $status = 0;
print $sock "3\n";
print $sock ("0" x 32) . "\n";
for (;;) {
	my $line = <$sock>;
	die "communication error: $!\n" unless $line;
	if ($line =~ /left door sings: ([0-9a-f]+)/) {
		if ($status == 0) {
			print $sock "3\n";
			print $sock substr($1, 32) . "\n";
			$status = 1;
		} else {
			if (substr($1, 0, 32) eq ("f" x 32)) {
				print $sock "2\n";
			} else {
				print $sock "1\n";
			}
			print $sock "3\n";
			print $sock ("0" x 32) . "\n";
			$status = 0;
		}
	}
	if (index($line, "sdctf{") >= 0) {
		print $line;
		last;
	}
}

close $sock;
