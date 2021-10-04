#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;
use MIME::Base64;

if (@ARGV != 2 && @ARGV != 3) {
	use File::Basename;
	my $name = basename($0, "");
	die "Usage: perl $name host port [partial_answer]\n";
}

if (@ARGV == 3 && (length($ARGV[2]) % 2 != 0 || $ARGV[2] !~ /\A([0-9a-fA-F]{2})*\z/)) {
	die "partial_answer must be a hexadecimal string with even length\n";
}

my $sock = new IO::Socket::INET(PeerAddr=>$ARGV[0], PeerPort=>int($ARGV[1]), Proto=>"tcp");
unless ($sock) { die "connection failed: $!\n"; }
binmode($sock);

my $block_size = 16;

<$sock>; # AES-128

sub to_hex {
	my $str = $_[0];
	my $len = length($str);
	my $res = "";
	for (my $i = 0; $i < $len; $i++) {
		$res .= sprintf("%02x", ord(substr($str, $i, 1)));
	}
	return $res;
}

sub query {
	my $pt = $_[0];
	print $sock "$pt\n";
	unless (defined(<$sock>)) { return; }; # Enter plaintext:
	my $resp = <$sock>;
	unless (defined($resp)) { return; }
	return MIME::Base64::decode_base64($resp);
}

# which block changes by changing the first byte of plaintext?

my $b1 = &query("a" . ("a" x $block_size));
my $b2 = &query("b" . ("a" x $block_size));

my $changed_block = -1;
for (my $i = 0; $i < length($b1); $i++) {
	if (substr($b1, $block_size * $i, $block_size) ne substr($b2, $block_size * $i, $block_size)) {
		$changed_block = $i;
		last;
	}
}
die "block didn't change by changing plaintext!\n" unless $changed_block >= 0;

print "changed_block = $changed_block [block]\n";

# what character in the plaintext corresponds to the new block?
# (move to new block -> changing a character don't affect previous block)
# (all of the 15 byte after the first byte affects the block firstly affected -> the first character is the beginning of a block)

my $new_block_start = 0;
for (my $i = 1; $i < $block_size; $i++) {
	my $b3 = &query(("a" x $i) . "b" . ("a" x ($block_size - $i)));
	if (substr($b1, $block_size * $changed_block, $block_size) eq substr($b3, $block_size * $changed_block, $block_size)) {
		$new_block_start = $i;
		last;
	}
}

print "new_block_start = $new_block_start [character]\n";

my $pre_pad = "a" x $new_block_start;
my $origin_block = $new_block_start == 0 ? $changed_block : $changed_block + 1;

my $len_test = &query($pre_pad);
my $target_len = length($len_test) - $block_size * $origin_block;
die "unaligned!\n" unless $target_len % $block_size == 0;
my $check_block = $origin_block + int($target_len / $block_size) - 1;

print "ciphertext = " . &to_hex($len_test) . "\n";

my $known_text = "a" x $target_len;

my $res = "";

if (@ARGV > 2) {
	my $pa = $ARGV[2];
	my $palen = length($pa);
	for (my $i = 0; $i < $palen; $i += 2) {
		$res .= chr(hex(substr($pa, $i, 2)));
	}
	$known_text = substr($known_text, length($res)) . $res;
}

for (my $i = length($res); $i < $target_len; $i++) {
	my $to_search = &query($pre_pad . ("a" x ($target_len - $i - 1)));
	my $ans = -1;
	printf STDERR "%3d/%3d ", $i, $target_len;
	for (my $j = 0; $j < 256; $j++) {
		if ($j % 0x10 == 0) { print STDERR "."; }
		if ($j == 0x0a) { next; } # entering newline character will break the search
		# add "a" as the last character to prevent chr($j) from being deleted by strip()
		my $check = &query($pre_pad . substr($known_text, 1) . chr($j) . "a");
		unless (defined($check)) {
			print STDERR "\nnetwork error!\n";
			last;
		}
		if (substr($to_search, $block_size * $check_block, $block_size) eq substr($check, $block_size * $check_block, $block_size)) {
			$ans = $j;
			last;
		}
	}
	print STDERR "\n";
	if ($ans < 0) {
		print STDERR "not found!\n";
		last;
	}
	$res .= chr($ans);
	$known_text = substr($known_text, 1) . chr($ans);
}

close($sock);

print &to_hex($res);
print "\n";
