/* Kush Parmar*/
/*I pledge my honor that i have abided by the stevens honor system*/
/*Project 1*/

.text
.global _start
.extern printf

CalFor:	
	FMOV D13, XZR		//F(something)
	FMOV D15, 1.0		//holder adds to F(something)
	MOV X14, 0		//index for first for loop i
	Mov X12, 0		//index for the first loop with offset
	FMov D11, XZR		//holds values from array
	Mov X10,0		//inner loop index
In:	CMP X14, X4	
	B.Le con		// if x14<=x4 (index<= N)
	RET			//else return
con:	LSL X12, x14, 3		//X12 offset calculation
	LDR D11, [X3, X12]	//D11 load  element
	FMov D15, 1.0		//reset to 0
InnerL:	Cmp X10, X14		//X10>=x14
	B.Ge OutofIn		//go to outofin if greater than or equal to
	FMul D15, D15, D8	//Calculates holder*= a b or c
	ADD X10, X10, 1		//increase index
	B InnerL		//go to InnnerL
OutofIn:FMUL D16, D15, D11	//this total= holder*arr[i]
	FADD D13, D13, D16	//f(something)+= total
	Mov X10, 0		//reset x10
	ADD X14, X14, 1		//increase x14
	B In			//go to IN
	

bisection:
	SUB SP, SP, 56		// create point
	STR X3,[SP,0]		//stores coeff
	STR x4,[SP,8]		//stores N
	STR D5,[SP,16]		//Stores A
	STR D6,[SP,24]		//Stores B
	STR D7,[SP,32]		//Stores precision 
	STR X0,[SP,40]		//Stores Max
	STR LR,[SP,48]		//Stores return
	FADD D8,D5,D6		//Adds c= a+B
	FMOV D17, 2		//x17=2
	FDIV D8, D8, D17	//divides by 2
	BL CalFor		// branch link CallFor
	FMov D17, -1
	FMul D17, D17, D7
	FCMP D13, D17		// check if greater than negative percision
	B.Gt ifInner		//if less than go to if inner
	B elseCh		//if not then go to elseCh
	
ifInner:FCMP D13, D7		// checks if its greater than 
	B.GT elseCh	
	ADR X0, str		//string there is a root
	FMOV D0, D13		//A value D1=D5
 	FMOV D1, D8		//B value D2=F(c)
	B Out
elseCh:	FMOV D18, D8		//D18=D8 holding c value
	FMOV D19, D13		//holding f(c) value
	FMOV D8, D5		//D8=D5 now holding a
	BL CalFor		//f(a)
	FMOV D20, D13		//D20= D8 holding a value
	FMOV D8, D6		//D8=d6
	Bl CalFor		//f(b)
	CMP X0, 0		//used to stop infinite loops 
	B.eq NoBisec		// go to noBisec
	Sub X0, X0, 1
restc:	FCMP D19, 0		//checks if f(c) value is less than 0
	B.LT  cCheckL
	FCMP D19, 0		//checks if f(c) value is greater than 0
	B.Gt cCheckG
	
replB:	FMov D6, D18		//d6=d18
	B iter 			//go to iter
	
replA:	FMov D5, D18		//d5=d18
	B iter			//go to liter

cCheckL:FCmp D20,0		//checks if f(a) value sign
	B.Lt replA		//is less than 0 if so then change a to c
	B replB			//else change b to c 

cCheckG:FCmp D20,0		//check if f(a) value sign
	B.gt replA		//is greater than 0 if so then change a to c
	B replB			//else change b 
	
NoBisec: Adr x0, noB		//loads no string
	 B Out			//there are no bisection

iter: BL bisection		//recurse
Out: 	LDR LR,[SP,48]		//load lr
	ADD SP, SP, 56		//de allocate sp
	RET			//return

inital: SUB SP, SP, 8		//allocate space
	STR LR,[SP]		//store return
	FCmp D5, D6
	B.Gt errors			
	FMul D2,D5,D6		//checks if a and b values valid
	FCmp D2, 0
	B.Gt errors		//go to errors
	Bl bisection		//branch to bisection
fin:	LDR LR,[SP]
	ADD SP, SP ,8
	Ret			//return main
errors:	Adr x0, invalid
	b fin

_start:
	Adr X3, coeff		//address to coeff
	//LDR D4, [D3] 		//loads first element at 
	Adr X4, N 		//address to n at X4
	LDR X4, [X4] 		//loads N to x4 
	ADR X5, A
	LDR D5, [X5]		//loads a value
	ADR x6, B
	LDR D6,[X6]		//loads b value
	ADR x7, T
	LDR D7, [X7] 		//X7= Perscision 
	ADR x0, Max		
	LDR x0,[x0]		//loads precision
	Bl inital		//branches to intial which checks a and b input then goes to bijective
	BL printf
	MOV	X0, 0		/*status := 0*/
	MOV	X8, 93		/*exit is syscall #1 */
	SVC	0		/* invoke syscall */

.data
	coeff:.double 5.3, 0.0, 2.9, -3.1
 	N: .dword 3
	A: .double -2		//negative
	B: .double 2		//postive
	T: .double 0.01
	Max: .dword 50		//we have a max amount just so we don't seg fault if we there is no bisection in that arrea
	str: .string "root: F(c)= %lf at c= %lf\n"
	noB: .string "No bisection\n"
	invalid: .string "a and b values not valid\n"
