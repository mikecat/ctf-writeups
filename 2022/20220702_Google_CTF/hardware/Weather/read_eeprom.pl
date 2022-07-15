#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket;

unless (@ARGV == 2 || @ARGV == 3) {
	die "Usage: port_brute.pl host port [start_page]\n";
}

my $sock = new IO::Socket::INET(PeerAddr=>$ARGV[0], PeerPort=>int($ARGV[1]), Proto=>"tcp");
unless ($sock) { die "connect error\n"; }

my $start_page = @ARGV >= 3 ? int($ARGV[2]) : 0;

binmode(STDOUT);
for (my $i = $start_page; $i < 64; $i++) {
	print STDERR "reading page $i\n";
	print $sock "w 101153 1 $i\n";
	for (;;) {
		my $line = <$sock>;
		unless ($line) { die "communication error while reading page $i\n"; }
		chomp($line);
		if (index($line, "i2c") >= 0) { last; }
	}
	print $sock "r 101153 64\n";
	for (;;) {
		my $line = <$sock>;
		unless ($line) { die "communication error while reading page $i\n"; }
		chomp($line);
		if (index($line, "i2c") >= 0) { last; }
	}
	my @data = ();
	for (;;) {
		my $line = <$sock>;
		unless ($line) { die "communication error while reading page $i\n"; }
		chomp($line);
		if (index($line, "-end") >= 0) { last; }
		my @data2 = split(/\s+/, $line);
		for (my $j = 0; $j < @data2; $j++) { push(@data, $data2[$j]); }
	}
	for (my $j = 0; $j < @data; $j++) {
		print chr($data[$j]);
	}
}

close($sock);
