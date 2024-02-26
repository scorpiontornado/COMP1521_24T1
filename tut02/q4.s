	.text
main:
	la	$a0, prompt	# printf("Enter a number: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", &x);
	syscall

	mul	$t0, $v0, $v0	# y = x * x;

	move	$a0, $t0	# printf("%d", y);
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("\n");
	li	$v0, 11
	syscall

	li	$v0, 0
	jr	$ra

	.data
prompt:
	.asciiz	"Enter a number: "
