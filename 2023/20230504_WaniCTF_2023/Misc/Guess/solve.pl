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

my $num = 10000;
my $tries = 15;

my $blockSize = int(($num + $tries - 1) / $tries);

my @answer = ();
for (my $i = 0; $i < $num; $i++) { push(@answer, -1); }

for (my $i = 0; $i < $tries; $i++) {
	my $offset = $blockSize * $i;
	my $query = "";
	for (my $j = 0; $j < $blockSize && $offset + $j < $num; $j++) {
		$query .= sprintf(" %d", $offset + $j) x ($j + 1);
	}
	$query = substr($query, 1) . "\n";
	print $sock "1\n";
	print $sock $query;
	for (;;) {
		my $line = <$sock>;
		die "communication error: $!\n" unless $line;
		my $start = index($line, "[");
		if ($start >= 0) {
			my $end = index($line, "]", $start);
			my @data = split(/, /, substr($line, $start + 1, $end - $start - 1));
			my %count = ();
			my @values = ();
			for (my $j = 0; $j < @data; $j++) {
				my $value = int($data[$j]);
				if (defined($count{$value})) {
					$count{$value}++;
				} else {
					$count{$value} = 1;
					push(@values, $value);
				}
			}
			for (my $j = 0; $j < @values; $j++) {
				my $value = $values[$j];
				$answer[$offset + $count{$value} - 1] = $value;
			}
			last;
		}
	}
}

print $sock "2\n";
print $sock join(" ", @answer) . "\n";

while (my $line = <$sock>) {
	if (index($line, "{") >= 0 || index($line, "Incorrect") >= 0) {
		print $line;
		last;
	}
}

close($sock);
