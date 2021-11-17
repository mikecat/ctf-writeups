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

my $num = 10000;

my @pos = ();
for (my $i = 0; $i < $num; $i++) {
	push(@pos, 0);
}

for (my $i = 0; (1 << $i) <= $num; $i++) {
	print "$i\n";
	my $query = "";
	for (my $j = 0; $j < $num; $j++) {
		if (($j >> $i) & 1) { $query .= " $j"; }
	}
	$query =~ s/^\s+//;
	print $sock "1\n";
	print $sock "$query\n";
	for (;;) {
		my $resp = <$sock>;
		unless ($resp) { die "connection error\n"; }
		if ($resp =~ /Stolen: \[([0-9, ]+)\]/) {
			my @respArray = split(/, /, $1);
			for (my $j = 0; $j < @respArray; $j++) {
				$pos[$respArray[$j]] |= 1 << $i;
			}
			last;
		}
	}
}

my @thelist = ();
for (my $i = 0; $i < $num; $i++) {
	push(@thelist, 0);
}
for (my $i = 0; $i < $num; $i++) {
	$thelist[$pos[$i]] = $i;
}

my $guess = join(" ", @thelist);
print $sock "2\n";
print $sock "$guess\n";

while (<$sock>) { print $_; }
close($sock);
