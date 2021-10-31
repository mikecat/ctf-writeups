#!/usr/bin/perl

use strict;
use warnings;

my $head_prefix = "hh_work/";
my @heads = ("dessicated_head", "fetid_head", "moldy_head", "putrid_head", "shrunken_head", "swollen_head");

my $body_prefix = "headless_horseman/distributed_files/body_bag/";
my @bodys = ("bloated_body", "decomposing_body", "rotting_body");

my $out_prefix = "gattai_out/";

for (my $i = 0; $i < @heads; $i++) {
	my $head_data = "";
	open(HEAD, "< $head_prefix$heads[$i]") or die "failed to open \$heads[$i]\n";
	binmode(HEAD);
	while (<HEAD>) { $head_data .= $_; }
	close(HEAD);

	for (my $j = 0; $j < @bodys; $j++) {
		my $body_data = "";
		open(BODY, "< $body_prefix$bodys[$j]") or die "failed to open \$bodys[$j]\n";
		binmode(BODY);
		while (<BODY>) { $body_data .= $_; }
		close(BODY);

		open(OUT, "> $out_prefix$heads[$i]_$bodys[$j]") or die "failed to open out[$i][$j]\n";
		binmode(OUT);
		print OUT $head_data;
		print OUT $body_data;
		close(OUT);
	}
}
