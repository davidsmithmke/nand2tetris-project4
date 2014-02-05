// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

(BEGIN)
	// Set keyboard to address for keyboard input value.
	@24576
	D=A
	@keyboard
	M=D
	// Set current to last screen pixel map.
	@24575
	D=A
	@current
	M=D
(CHECK_KEYBOARD)
	// If keyboard is pressed, fill the screen.
	@keyboard
	A=M
	D=M
	@FILL
	D;JNE
	// Otherwise, clear the screen.
	@CLEAR
	0;JMP
(FILL)
	// Fill current pixel.
	@current
	A=M
	M=-1
	// If current pixel map is first pixel map there is nothing left to fill, so
	//jump back to keyboard check.
	@current
	D=M
	@16384
	D=D-A
	@CHECK_KEYBOARD
	D;JLE
	// Decrement current pixel map.
	@current
	M=M-1
	// Continue filling next pixel map.
	@FILL
	0;JMP
(CLEAR)
	// Clear current pixel.
	@current
	A=M
	M=0
	// If current pixel map is last pixel map there is nothing left to clear, so
	// jump back to keyboard check.
	@current
	D=M
	@24575
	D=D-A
	@CHECK_KEYBOARD
	D;JGE
	// Increment current pixel map.
	@current
	M=M+1
	// Continue clearing next pixel map.
	@CLEAR
	0;JMP