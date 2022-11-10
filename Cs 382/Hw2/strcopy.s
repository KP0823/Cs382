/* Kush Parmar*/
/*I pledge my honor that i have abided by the stevens honor system*/
/*homework 2*/
.text
.global _start

_start:
	ADR X1, src_str 	/*adr for scr_str*/
	ADR X0, dst_str 	/*adr for dst_str*/
	MOV X3, 0 		/*index of string*/
	MOV w4, 0 		/*holds char of string X1*/
ForLoop:
	LDRB w4, [X1,X3] 	/*loads char from string x1 */
	CMP w4, 0x00 		/*checks if it is a null terminator*/
	B.eq endLine 		/* if it is go to endLine*/
	B ifState 		/*if not then go to if check*/
ifState:
	STRB w4, [X0,X3] 	/*stores char into X0*/
	ADD X3, X3, 1 		/*adds one to index*/
	B ForLoop 		/*go to for loop*/
endLine:
	STRB w4, [X0, X3]	/*stores null terminator*/
	MOV	X0, 0		/*status := 0*/
	MOV	X8, 93		/*exit is syscall #1 */
	SVC	0		/* invoke syscall */

.data
	src_str: .string "I love 382 and assembly!"

.bss
	dst_str: .skip 100 // destination string
