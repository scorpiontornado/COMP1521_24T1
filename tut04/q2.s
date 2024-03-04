# This program prints out a danish flag, by
# looping through the rows and columns of the flag.
# Each element inside the flag is a single character.
# (i.e., 1 byte).
#
# (Dette program udskriver et dansk flag, ved at
# sløjfe gennem rækker og kolonner i flaget.)
#

# Constants
FLAG_ROWS = 6
FLAG_COLS = 12

# Registers:
# - row in $t0
# - col in $t1
# - row offset in $t2
# - row+col offset in $t3
main:
	row_loop__init:
		li	$t0, 0						# row = 0;
	row_loop__cond:
		bge	$t0, FLAG_ROWS, row_loop__end
	row_loop__body:
		col_loop__init:
			li	$t1, 0					#   col = 0;
		col_loop__cond:
			bge	$t1, FLAG_COLS, col_loop__end		#   while (col < FLAG_COLS) {
		col_loop__body:
			mul	$t2, $t0, FLAG_COLS			#     row * N_COLS
			add	$t3, $t2, $t1				#     row * N_COLS + col
									#     would mul by sizeof(element), but sizeof(char) is 1
			# la	$t4, flag
			# add	$t5, $t3, $t4				#     &array[row][col] = array + offset * sizeof(element)
									#     &array[row][col] = array + ((row * N_COLS) + col) * sizeof(element)
			# lb	$v0, ($t5)

			lb 	$a0, flag($t3)				#   
			li	$v0, 11					#   (accidentally had 1, not 11, in the tute)
			syscall
		col_loop__step:
			addi	$t1, 1					#   col++;
			j	col_loop__cond
		col_loop__end:						# }

		li	$a0, '\n'
		li	$v0, 11
		syscall
	row_loop__step:
		addi	$t0, 1						# row++;
		j	row_loop__cond
	row_loop__end:

	# Forgot the epilogue in the tut, so got an error when jumping to row_loop__end
	#   ("could not find instruction at 0x00400060" - i.e., there was no code for row_loop__end to "point" to)
	li	$v0, 0
	jr 	$ra

.data
# This label inside the data region refers to the bytes of the flag.
# Note that even thought the bytes are listed on separate lines,
# they are actually stored as a single contiguous chunk or 'string' in memory.
flag:
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'