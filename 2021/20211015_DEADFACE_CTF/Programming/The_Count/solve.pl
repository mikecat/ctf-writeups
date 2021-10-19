#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;

if (@ARGV != 2) {
	use File::Basename;
	my $name = basename($0, "");
	die "Usage: perl $name host port\n";
}

my $sock = new IO::Socket::INET(PeerAddr=>$ARGV[0], PeerPort=>int($ARGV[1]), Proto=>"tcp");
unless ($sock) { die "connection failed: $!\n"; }
binmode($sock);

sub send_data {
	my $data = $_[0];
	print $data;
	print $sock $data;
}

while (my $line = <$sock>) {
	print $line;
	if ($line =~ /Your word is: ([a-z]+)/) {
		my $sum = 0;
		my $query = $1;
		my $len = length($query);
		my $start = ord("a");
		for (my $i = 0; $i < $len; $i++) {
			$sum += ord(substr($query, $i, 1)) - $start;
		}
		&send_data("$sum\n");
	}
}

close($sock);
