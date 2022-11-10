/* Kush Parmar*/
/*I pledge my honor that i have abided by the stevens honor system*/
/*homework 2*/
.text
.global _start
_start:
	ADR X0, arr		/*address of arr X1*/
	ADR X3, length 		/*address of length X11*/
	
	MOV X4, 0		/*index which iterates through arr*/
	LDUR W2, [X3]		/*Loads length and will be our upperbound*/
	Sub W2, W2,1		/*-1 so we can use the this size in swapper*/
	LSL X2,X2, 2		/*each word 4 bytes so we need to move by 4s*/
	
SwapsFor:SUBS XZR, X4, X2	/*checks to see if x4 less than x2*/
	B.LT Swapper		/*go to swapper*/
	LDR W2, [X3]		/*Loads length and will be our upperbound*/
	LSL X2, X2, 2		/*each word 4 bytes so we need this to move by 4s*/
	MOV X4, 0		/*X4 holds 0*/
	B Prepare		/*go to Prepare*/
	
Swapper:LDR W5, [X0,X4]		/*Loads element from arr*/
	LDR W8, [X0,X2]		/*Loads element from arr*/
	STR W5, [X0,X2]		/*swaps elements*/
	STR W8, [X0,X4]		/*swaps elements*/
	ADD X4, X4, 4		/*moves index by 4*/
	SUB W2, W2, 4		/*moves index by -4*/
	B SwapsFor		/*go to swaps for*/

Prepare:MOV W5, 28		/* start at 28 for left shifts*/
	MOV W8, 28		/* start at 28 for right shifts*/
	MOV W7, 0x00000000	/*creates orginal hex value*/
	SUBS XZR, X4,X2		/*checks if its in range of size*/
	B.LT Sort		/*go to sort*/
	B Out			/*else go to out*/
	
Sort:	Subs WZR, W5, 0		/*checks if W5 is equal to 0*/
	B.LT Storing		/*this is check*/
	LDR W6,[X0,X4]		/*loads element from arr*/
	LSL W6, W6,W5		/*shifts left W5 amount*/
	LSR W6, W6,W8		/*shifts right w8 amount*/
	LSL W7, W7,4 		/*shifts to the left by 4*/
	ORR W7, W7 ,W6		/*concatenates both hexs*/
	Sub W5, W5, 4		/*reduce amount to shift left*/
	B Sort			/*go to sort*/

Storing:
	STR W7,[X0, X4]		/*Stores new hex value in arr*/
	ADD X4,X4,4		/*moves x4 index by 4*/
	B Prepare		/*go to prepare*/
	
Out:
	MOV	X0, 0		/*status := 0*/
	MOV	X8, 93		/*exit is syscall #1 */
	SVC	0		/* invoke syscall */

.data
	arr:	.word 0x12BFDA09, 0x9089CDBA, 0x56788910
	length:	.word 3
