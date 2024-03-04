# Find the largest element in an array, recursively.
# Modified from tut04 answers

max:
	# Args:
	#    - $a0: int array[]
	#    - $a1: int length
	#
	# Returns:
	#    - $v0: int
	#
	# Frame:    [$ra, $s0]
	# Uses:     [$ra, $s0, $v0, $a0, $a1, $t0]
	# Clobbers: [$v0, $a0, $a1, $t0]
	#
	# Locals:
	#   - $s0: int first_element
	#   - $t0: int max_so_far
	#
	# Structure:
	#   play_tick
	#   -> [prologue]
	#       -> body
	#           -> max__base_case
	#           -> max__length_gt_1
	#           -> max__ret_max_so_far
	#   -> [epilogue]
max__prologue:
	begin
	push	$ra			# Push $ra and $s0 to the stack to save their original values
	push	$s0			#   (by convention, we expect the $s and $ra registers to be preserved after
					#   calling a function -- including this one)
max__body:
	lw	$s0, ($a0)		# Load the value of array[0] into $s0

	bne	$a1, 1, max__length_gt_1	# if (length != 1), go to the recursive case

max__base_case:				# Base case of recursion
	move    $v0, $s0		# return first_element;
	b	max__epilogue

max__length_gt_1:			# Recursive case
	addi	$a0, 4			# Get the address of array[1] by adding 4 to the address `array`
					# 	(as each element has a size of 4 bytes)
	addi	$a1, -1			# length = length - 1;
	jal	max			# recursive call:
					#  NOTE: we must assume all registers but $s? and $ra were "clobbered" (wiped)
	move	$t0, $v0		# max_so_far = max(&array[1], length - 1);

	ble	$s0, $t0, max__ret_max_so_far	# if (first_element <= max_so_far) goto max__ret_max_so_far;
	move	$t0, $s0			# max_so_far = first_element

max__ret_max_so_far:
	move	$v0, $t0		# return value is max_so_far

max__epilogue:
	pop	$s0			# pop $s0 and $ra from the stack in the opposite order we pushed them in
	pop	$ra
	end

	jr	$ra			# return; ($v0 will differ based on what we're returning)

	# Simple test code that calls max
main:
main__prologue:
	push	$ra

main__body:
	la	$a0, array
	li	$a1, 10
	jal	max			# result = max(array, 10)

	move	$a0, $v0
	li	$v0, 1			# syscall 1: print_int
	syscall				# printf("%d", result)

	li	$a0, '\n'
	li	$v0, 11			# syscall 11: print_char
	syscall				# printf("%c", '\n');

	li	$v0, 0

main__epilogue:
	pop	$ra
	jr	$ra			# return 0;

	.data
array:
	.word 1, 2, 3, 4, 5, 6, 4, 3, 2, 1