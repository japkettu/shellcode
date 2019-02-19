; open-read-write
; nasm -felf64 readFile.nasm -o readFile.o && ld readFile.o

global _start
section .text
_start:

jmp path
code:

;open
pop rdi
xor eax, eax
add eax, 2
xor esi, esi
syscall

;read
mov edi, eax
xor eax, eax
xor edx, edx
mov rsi, rsp
add edx, 50
syscall

; write
mov dh, ah
xor eax, eax
add eax,1
mov rsi, rsp
xor rdi, rdi
add rdi, 1
syscall

;exit
xor eax, eax
add eax, 60
syscall

path:
call code
var  db "/etc/passwd"
