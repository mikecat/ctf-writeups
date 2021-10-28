#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;

my $sockServer = new IO::Socket::INET(Listen=>5, LocalAddr=>"0.0.0.0", LocalPort=>7777, Proto=>"tcp", Reuse=>1);
die "socket creation failed: $!\n" unless $sockServer;

for (;;) {
	my $sock = $sockServer->accept();
	my $req = "";
	while (my $line = <$sock>) {
		chomp($line);
		if ($req eq "") {
			$req = $line;
			$req =~ s/[\r\n]+//g;
		}
		if ($line eq "" || $line eq "\r") { last; }
	}
	print "$req\n";
	binmode($sock);
	print $sock "HTTP/1.0 200 OK\r\n";
	print $sock "Content-Type: text/plain\r\n";
	print $sock "Content-Length-Fake: 1023\r\n";
	print $sock "Content-length: 26\r\n";
	print $sock "Connection: close\r\n";
	print $sock "\r\n";
	print $sock "hello, world\n";
	print $sock "hello, world\n";
	close($sock);
}
