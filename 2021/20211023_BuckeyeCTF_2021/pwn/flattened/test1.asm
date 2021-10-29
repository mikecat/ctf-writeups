bits 64

lea rax, [rel pos]
pos:
push rax
xor edi, edi
mov rsi, rsp
mov edx, 4
mov eax, 1
syscall
mov eax, 60
xor edi, edi
syscall
