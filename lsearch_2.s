	.globl lsearch_2
_lsearch_2:                             ## @lsearch_2

	# %rax = return
	# %rsi = n
	# %rcx = i
	# %r8d = tmp

else:
	testl	%esi, %esi
	jle	if						# if n <= 0

	movslq	%esi, %rax				# return = n
	movl	-4(%rdi,%rax,4), %r8d	# tmp = A[n-1]
	movl	%edx, -4(%rdi,%rax,4)
	leaq	-1(%rax), %rsi
	movl	$-1, %ecx				# i = -1
	movq	%rdi, %rax

while:                                 
	incl	%ecx					# i++
	cmpl	%edx, (%rax)		
	leaq	4(%rax), %rax
	jne	while						# result != 0

	movl	%r8d, (%rdi,%rsi,4)		# A[n-1] = tmp
	cmpl	%edx, %r8d				# tmp <= (n-1)
	movl	$-1, %eax				# return = -1
	cmovel	%esi, %eax
	cmpl	%esi, %ecx				
	cmovll	%ecx, %eax
	retq

if:
	movl	$-1, %eax	# return = -1
	retq
