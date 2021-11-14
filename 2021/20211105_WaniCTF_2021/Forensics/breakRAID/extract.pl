#!/usr/bin/perl

use strict;
use warnings;

use Compress::Raw::Zlib;

my @files = ("disks/disk01", "disks/disk02", "disk-xored");
my %ids = ("disk01", 0, "disk02", 1, "disk-xored", 2);

my $out_prefix = "extracted/";

my ($fp0, $fp1, $fp2);
open($fp0, "< $files[0]") or die "failed to open $files[0]\n";
open($fp1, "< $files[1]") or die "failed to open $files[1]\n";
open($fp2, "< $files[2]") or die "failed to open $files[2]\n";
binmode($fp0);
binmode($fp1);
binmode($fp2);
my @fps = ($fp0, $fp1, $fp2);

sub get_data {
	my ($id, $offset, $size) = @_;
	seek($fps[$id], $offset, 0);
	my $res = "";
	read($fps[$id], $res, $size);
	return $res;
}

my $fid = 0;
while (my $line = <STDIN>) {
	chomp($line);
	if ($line =~ /([0-9a-fA-F]+)( IHDR)? - ([0-9a-fA-F]+)( IEND)?/) {
		my $start = hex($1);
		my $end = hex($3);
		if (defined($2)) { $start -= 12; }
		if (defined($4)) { $end += 8; }
		my $data = get_data($fid, $start, $end - $start);
		my $filename = "$out_prefix$1.png";
		open(OUT, "> $filename") or die "failed to open $filename\n";
		binmode(OUT);
		print OUT $data;
		close(OUT);
	} elsif (defined($ids{$line})) {
		$fid = $ids{$line};
	}
}

close($fp0);
close($fp1);
close($fp2);
