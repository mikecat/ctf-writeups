#!/usr/bin/perl

use strict;
use warnings;

my $runtime_file = @ARGV > 0 ? $ARGV[0] : "qasm/qasm";
my $program_file = @ARGV > 1 ? $ARGV[1] : "qasm/prog.qasm";

my $rt = "";
open(RT, "< $runtime_file") or die "failed to open $runtime_file\n";
binmode(RT);
while (<RT>) { $rt .= $_; }
close(RT);

my $prog = "";
open(PROG, "< $program_file") or die "failed to open $program_file\n";
binmode(PROG);
while (<PROG>) { $prog .= $_; }
close(PROG);

my $atable_offset = 0x6040;
my $inst_max = 0x72;
my @atable = unpack("L$inst_max", substr($rt, $atable_offset, 4 * $inst_max));

my %inst_name = (
	0x00, "mov_r_imm",
	0x01, "mov_r_r",
	0x02, "end",
	0x10, "add_r_imm",
	0x11, "add_r_r",
	0x12, "sub_r_imm",
	0x13, "sub_r_r",
	0x14, "mul_r_imm",
	0x15, "mul_r_r",
	0x16, "div_r_imm",
	0x17, "div_r_r",
	0x18, "mod_r_imm",
	0x19, "mod_r_r",
	0x20, "bitnot_r",
	0x21, "bitand_r_imm",
	0x22, "bitand_r_r",
	0x23, "bitxor_r_imm",
	0x24, "bitxor_r_r",
	0x25, "bitor_r_imm",
	0x26, "bitor_r_r",
	0x30, "iszero_0_r",
	0x31, "isneg_0_r",
	0x32, "ispos_0_r",
	0x40, "jmp_imm",
	0x41, "jmp_r",
	0x42, "jnz_0_imm",
	0x43, "jnz_0_r",
	0x50, "pushright_imm",
	0x51, "pushright_r",
	0x52, "popleft_r",
	0x53, "peekleft_r",
	0x54, "extleft_imm",
	0x55, "extleft_r",
	0x56, "extright_imm",
	0x57, "extright_r",
	0x58, "shiftleft_imm",
	0x59, "shiftleft_r",
	0x5a, "shiftright_imm",
	0x5b, "shiftright_r",
	0x5c, "getqlen_r",
	0x5d, "resize_imm",
	0x5e, "resize_r",
	0x5f, "getqsum_r",
	0x60, "label",
	0x70, "readstr",
	0x71, "write_imm",
);

my $plen = length($prog);
for (my $i = 0; $i < $plen; ) {
	my $inst = ord(substr($prog, $i, 1));
	$i++;
	if ($inst < $inst_max) {
		my $anum = $atable[$inst];
		my @inst_args = ();
		for (my $j = 0; $j < $anum; $j++) {
			if ($i >= $plen) {
				die "unexpected EOF\n";
			}
			push(@inst_args, ord(substr($prog, $i, 1)));
			$i++;
		}
		if (defined($inst_name{$inst})) {
			print "$inst_name{$inst}";
			if ($anum > 0) {
				print " ";
				print $inst_args[0];
				for (my $j = 1; $j < @inst_args; $j++) {
					print ", ";
					print $inst_args[$j];
				}
			}
			print "\n";
		}
	}
}
