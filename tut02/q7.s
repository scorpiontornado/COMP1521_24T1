	.text
# Locals:
# 	$t0: int x
main:
loop__init:
	li	$t0, 24
loop__cond:
	bge	$t0, 42, loop__end
loop__body:
	move	$a0, $t0
	li	$v0, 1
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

loop__step:
	addi	$t0, 3		# x += 3
	# addi	$t0, $t0, 3
	j	loop__cond
loop__end:

	li	$v0, 0
	jr 	$ra

	.data