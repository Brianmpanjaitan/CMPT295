	.globl conv_arr
conv_arr:
	movq $0, %r9	# counter i <- 0	
	movq %rsi, %r10	# scratch <- n
	addq %rcx, %r10	# scratch <- n+m
	subq $2, %r10	# n+m-2

loop:
	cmpq %r9, %r10	# (n+m-2)-i ? 0
	jl endloop	# (n+m-2)-i < 0
	incq %r9	# i++
	
	pushq %rdi	# save the caller registers onto the stack
	pushq %rsi
	pushq %rdx
	pushq %rcx

	pushq %rdi	# push x
	pushq %rsi	# push n
	movq %r9, %rdi	# rdi (1st parameter) <- i+1
	movq %rcx, %rsi	# rsi (2nd parameter) <- m
	call min	# rax <- ladj = min(i+1,m)
	
	popq %rdi	# rdi <- n
	push %rax	# push ladj onto the stack
	addq %rcx, %rdi	# rdi <- n+m
	subq %r9, %rdi	# rdi <- n+m-(i+1)
	call min	# rax <- radj = min(n+m-(i+1),m)

	subq %rax, %rcx
	popq %r11	# r11 <- ladj
	popq %rdi	# rdi <- x
	pushq %r9	# save i+1 onto the stack
	subq %r11, %r9	# r9 <- (i+1)-ladj
	addq %r9, %rdi	# rdi <- x+(i+1)-ladj

	movq %rcx, %rsi	# rsi <- radj
	addq %rdx, %rsi	# rsi <- radj+h

	subq %rcx, %r11	# r11 <- ladj-radj
	movq %r11, %rdx	# rdx (3rd parameter) <- r11

	call conv
	movb %al, (%r8)	# result[i] <- return
	incq %r8	# result[i++]

	popq %r9	#restore callee registers after loop iteration
	popq %rcx
	popq %rdx
	popq %rsi
	popq %rdi
	jmp loop


endloop:
	ret


