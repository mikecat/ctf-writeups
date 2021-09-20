#!/usr/bin/perl

use strict;
use warnings;

my $filename = @ARGV >= 1 ? $ARGV[0] : "tour/tour";
my $offset = @ARGV >= 2 ? int($ARGV[1]) : 0x3020;
my $num = @ARGV >= 3 ? int($ARGV[2]) : 0xf;

my $data = "";
open(DATA, "< $filename") or die "failed to open $filename\n";
binmode(DATA);
while (<DATA>) { $data .= $_; }
close(DATA);

my @data2 = unpack(sprintf("L%d", $num * $num), substr($data, $offset));

my @next_move = ();
for (my $i = 0; $i < $num * $num; $i++) {
	push(@next_move, $i % $num);
}

for (my $k = 0; $k < $num; $k++) {
	for (my $i = 0; $i < $num; $i++) {
		for (my $j = 0; $j < $num; $j++) {
			if ($data2[$i * $num + $j] > $data2[$i * $num + $k] + $data2[$k * $num + $j]) {
				$data2[$i * $num + $j] = $data2[$i * $num + $k] + $data2[$k * $num + $j];
				$next_move[$i * $num + $j] = $k;
			}
		}
	}
}

my %memo = ();

sub solve {
	my ($current, $visited) = @_;
	my $key = "$current\t$visited";
	if (defined($memo{$key})) {
		return $memo{$key};
	}
	if ($visited == ((1 << $num) - 1)) {
		return sprintf("%d\t-1", $data2[$current * $num + 0]);
	}
	my $best = -1;
	my $best_score = -1;
	for (my $i = 0; $i < $num; $i++) {
		unless (($visited >> $i) & 1) {
			my ($candidate, $unused) = split(/\t/, &solve($i, $visited | (1 << $i)));
			$candidate += $data2[$current * $num + $i];
			if ($best_score < 0 || $candidate < $best_score) {
				$best = $i;
				$best_score = $candidate;
			}
		}
	}
	my $ans = "$best_score\t$best";
	$memo{$key} = $ans;
	return $ans;
}

my $current = 0;
my ($score, $move) = split(/\t/, &solve(0, 1));
my $visited = 1;

print "score = $score\n";
while ($move >= 0) {
	$visited |= 1 << $move;
	while ($current != $move) {
		my $next = $next_move[$current * $num + $move];
		print "$next\n";
		$current = $next;
	}
	($score, $move) = split(/\t/, &solve($move, $visited));
}

while ($current != 0) {
	my $next = $next_move[$current * $num + 0];
	print "$next\n";
	$current = $next;
}
