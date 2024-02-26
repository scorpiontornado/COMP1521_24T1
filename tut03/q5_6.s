# Parts of a loop:
# - init -> optional
#	initialise variables
# - cond -> need
#	if false, goto end
# - body -> optional
#	do stuff
# - step -> only need if using continue / have a single if in body (if condition false, goto step)
#	make sure to increment & goto cond
# - end -> need

N_SIZE = 10					# #define N_SIZE 10

main:
scan_loop__init:
	li	$t0, 0				# int i = 0;

scan_loop__cond:
	bge	$t0, N_SIZE, scan_loop__end	# while (i < N_SIZE) {

scan_loop__body:
	li	$v0, 5				#   syscall 5: scan int
	syscall					#   ($v0 now contains scanned num)

	# la	$t1, numbers			#   base = numbers; (i.e., the address of the start of the array)
	# mul	$t2, $t0, 4			#   offset = i * sizeof(int);
	# add	$t3, $t1, $t2			#   address = base + offset;
	# sw	$v0, ($t3)			#   *address = scanned num;
						#     must use sw, not sb (ints are 4 bytes)

	mul	$t1, $t0, 4			#   offset = i * sizeof(int);
	sw	$v0, numbers($t1) 		#   *(numbers + offset) = $v0;
						#     i.e, numbers[i] = $v0;

scan_loop__step:
	addi	$t0, 1				#   i++;
	b	scan_loop__cond			# }

scan_loop__end:

	li	$v0, 11				# syscall 11: print char
	li	$a0, '\n'			#
	syscall					# printf("\n");

print_loop__init:
	li	$t0, 0				# i = 0;

print_loop__cond:
	bge	$t0, N_SIZE, print_loop__end	# while (i < N_SIZE) {

print_loop__body:
	mul	$t1, $t0, 4			#   offset = i * sizeof(int);
	lw	$a0, numbers($t1) 		#   $a0 = *(base + offset);
						#     i.e., $a0 = numbers[i];

	li	$v0, 1				#    syscall 1: print int
	syscall					#    printf("%d", numbers[i]);

	li	$v0, 11				#    syscall 11: print char
	li	$a0, '\n'			#
	syscall					#    printf("\n");

print_loop__step: # (maybe)
	addi	$t0, 1				#    i++;
	b	print_loop__cond		# }

print_loop__end:
	li  	$v0, 0          		# return 0;
	jr	$ra

	.data
numbers:
	.word 0:N_SIZE				# int numbers[10] = {0};

# string0:					# Could print a prompt before the scan loop
	# .asciiz "Enter a number: "