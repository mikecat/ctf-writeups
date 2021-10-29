bits 64

pos:
mov rax, 0x6161616161616161
push 0x0a
push rax
push rax
mov rdx, rsp
mov al, dl
and al, 0xf
add [rsp + 15], al

%macro put_one_digit 1
shr rdx, 4
mov al, dl
and al, 0xf
add [rsp + %1], al
%endmacro
put_one_digit 14
put_one_digit 13
put_one_digit 12
put_one_digit 11
put_one_digit 10
put_one_digit 9
put_one_digit 8
put_one_digit 7
put_one_digit 6
put_one_digit 5
put_one_digit 4
put_one_digit 3
put_one_digit 2
put_one_digit 1
put_one_digit 0

mov edi, 1
mov rsi, rsp
mov edx, 17
mov eax, 1
syscall
mov eax, 60
xor edi, edi
syscall
