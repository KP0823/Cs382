/* Kush Parmar*/
/*I pledge my honor that i have abided by the stevens honor system*/
/*homework 2*/
.text
.global _start
.extern printf


_start:
	ADR X1, arr		/*Address to arr*/
	ADR X2, length 		/*Address to high*/
	ADR X7, target		/*Address target*/
	LDUR X11,[X7]		/*load target*/
	LDR X3, [X2] 		/*Load high*/
	Sub X3, X3,1		/*Actual high*/
	MOV X4, 0 		/*Low*/
	MOV X5, 0 		/*Middle*/
	MOV X6, 0 		/*Comparing*/
	MOV X12, 0		/*Holding value*/

While:	SUBS X6, X3, X4		/* high-low*/
	SUBS XZR, X6, 1		/*high-low >1*/
	B.GT Inner		/*go to inner*/
	B LCheck		/*else go to check*/

Inner:	ADD X5, X3, X4		/*middle = high + low*/
	ASR X5, X5, 1		/*middle/=2*/
	LSL X12, X5, 3		/*holding value = middle *8*/
	LDR X8,[X1, X12]	/*load to X8, at offset holding value*/
	CMP X8, X11		/*compare is X8 is less than target*/ 
	B.LT AddOne		/*go to AddOne if less than*/
	B Else			/*else go to else*/
		
LCheck:	LSL X12, X4, 3		/*x12= low*8*/
	LDR X8, [X1,X12]	/*load to x8, at offset holding value*/
	CMP X8, X11		/*compare X8 and X11 if equal go to PrintAn*/
	B.eq PrintAn		/*go to PrintAn*/
	LSL X12, X3, 3		/*x12= high*8*/
	LDR X8, [X1,X12]	/*load to x8, at offset holding value*/
	CMP X8, X11		/*compare x8 and x11 if equal go to PrintAn*/
	B.eq PrintAn		/*go to PrintAn*/
	B Non			/*else go to non*/
	
AddOne: ADD X4, X4, 1		/*low++*/
	B While			/*go to while*/
	
Else:	MOV X3, X5		/*high=middle*/
	B While			/*got to while*/

PrintAn:ADR X0, msg1		/*X0 points to msg1*/
	MOV X1, X11		/*X1 equals target*/
	BL printf		/*print X0*/
	B Ending		/*go to ending*/
	
Non:	ADR X0, msg2		/*X0 points to msg2*/
	MOV X1, X11		/*x1 equals target*/
	BL printf		/*print X0*/
	B Ending		/*go to ending*/

Ending:	MOV	X0, 0		/*status := 0*/
	MOV	X8, 93		/*exit is syscall #1 */
	SVC	0		/* invoke syscall */


	
.data
	arr: .quad -40, -25, -1, 0, 100, 300
	length: .quad 6
	target: .quad -25
	msg1: .string "Target %ld is in the array\n."	/*added "\n"*/
	msg2: .string "Target %ld is not in the array\n." /*added "\n"*/
