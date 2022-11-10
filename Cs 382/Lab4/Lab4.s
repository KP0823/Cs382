/* Kush Parmar*/
/*I pledge my honor that i have abided by the stevens honor system*/
.text
.global _start

_start:
	ADR	X0, vec1	/*X0 register for vec1*/
	ADR	X1, vec2	/*X1 register for vec1*/
	ADR	X2, dot		/*X2 register for dot*/
	MOV X7, 0		/*X7 makes empty register to hold values*/
	
	LDUR X3,[X0, 0]	/*first index of vec1*/
	LDUR X4,[X1, 0]	/*first index of vec2*/
	MUL	X5, X3, X4	/*multplies values*/
	ADD	X7, X7, X5 	/*adds values to X7*/
	
	LDUR X3,[X0, 8]	/*Second index of vec1*/
	LDUR X4,[X1, 8]	/*Second index of vec1*/
	MUL	X5, X3, X4 /*multplies values*/
	ADD	X7, X7, X5 /*adds values to X7*/
	
	LDUR X3,[X0, 16]	/*Third index of vec1*/
	LDUR X4,[X1, 16]	/*Third index of vec1*/
	MUL	X5, X3, X4		/*multplies values*/
	ADD	X7, X7, X5	/*adds values to X7*/
	
	STUR X7,[X2,0]	/*Stores X2 into X2*/
	

	MOV	X0, 0	/*status := 0*/
	MOV	X8, 93	/*exit is syscall #1 */
	SVC	0	/* invoke syscall */

.data
	vec1:	.quad	10, 20, 30
	vec2:	.quad	1, 2, 3
	dot:	.quad	0
