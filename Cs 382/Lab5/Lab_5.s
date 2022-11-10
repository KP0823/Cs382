/* Kush Parmar*/
/*I pledge my honor that i have abided by the stevens honor system*/
/*Lab 5*/
.text
.global _start

_start:
	ADR	X2, p1	/*X2 register for p1*/
	ADR	X3, p2	/*X3 register for p2*/
	ADR	X4, p3	/*X4 register for p3*/
	MOV	X5, 0	/*X5 register that holds a*/
	MOV	X6, 0	/*X6 register that holds b*/
	MOV	X7, 0	/*X7 register that holds c*/
	MOV	X10,0	/*X10 holds moving values*/
	
	/* x values*/
	LDUR	X8,	[X2,0] /*first index in p1 x values*/
	LDUR	X9,	[X3,0] /*first index in p2 x values*/
	LDUR	X11,	[X4,0] /*first index in p3 x values*/
	
	SUBS	X10, X8, X9 /*signed subtraction of p1 x and p2 x*/
	MUL	X5, X10, X10 /*squares the values of p1 x and p2 x* and places in X7/ 
	MOV 	X10,0 /*reset mover*/

	SUBS	X10, X8, X11 /*signed subtraction of p1 x and p3 x*/
	MUL	X6, X10, X10 /*squares the values of p1 x and p3 x* and places in X6/
	MOV 	X10,0 /*reset mover*/

	SUBS	X10, X9, X11 /*signed subtraction of p2 x and p3 x*/
	MUL	X7, X10, X10 /*squares the values of p2 x and p3 x* and places in X6/
	MOV 	X10,0 /*reset mover*/
	
	/* y values*/
	LDUR	X8,	[X2,8] /*second index in p1 y values*/
	LDUR	X9,	[X3,8] /*second index in p2 y values*/
	LDUR	X11,	[X4,8] /*second index in p3 y values*/
	
	SUBS	X10, X8, X9 /*signed subtraction of p1 y and p2 y*/
	MUL	X10, X10, X10 /*squares the values of p1 y and p2 y*/ 
	ADDS	X5, X5, X10 /* adds squared values to X5*/
	MOV 	X10,0 /*reset mover*/

	SUBS	X10, X8, X11 /*signed subtraction of p1 y and p3 y*/
	MUL	X10, X10, X10 /*squares the values of p1 y and p3 y*/
	ADDS	X6, X6, X10 /* adds squared values to X6*/
	MOV 	X10,0 /*reset mover*/
	
	SUBS	X10, X9, X11 /*signed subtraction of p2 y and p3 y*/
	MUL	X10, X10, X10 /*squares the values of p2 y and p3 y*/
	ADDS	X7, X7, X10 /* adds squared values to X7*/
	MOV 	X10,0 /*reset mover*/	
	
	/*compares values*/
	MOV  X12,0
	
	ADDS X12, X5, X6 /*adds x5 and x6 to x12*/
	CMP  X12, X7 /*compares x12 to x7*/
	B.EQ Done /*if they are equal then moves to Done*/
	B L1 /*else move to L1 if check*/
	
L1:	ADDS X12, X5, X7 /*adds x5 and x7 to x12*/
	CMP X12, X6 /*compares x12 to x6*/
	B.EQ Done /*if they are equal then moves to Done*/
	B L2 /*else move to L2 if check*/
	
L2:	ADDS X12, X6, X7 /*adds x6 and x7 to x12*/
	CMP X12, X5 /*compares x12 to x5*/
	B.EQ Done /*if they are equal then moves to Done*/
	B Wrong /* since it was the last case we know that this not a right triangle*/
	
Wrong:	ADR X1, no /*X1 points to no*/
	B End /* move to ending*/

Done:	ADR X1, yes /*X1 points to yes*/

End:
	MOV	X0, 0	/*status := 0*/
	MOV	X8, 93	/*exit is syscall #1 */
	SVC	0	/* invoke syscall */

.data
	p1:		.quad 	0,	0
	p2:		.quad	0,	2
	p3:		.quad	2,	0
	yes:	.string	"It is a right triangle."
	no:		.string	"It is not a right triangle."
