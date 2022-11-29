/* Kush Parmar*/
/*I pledge my honor that i have abided by the stevens honor system*/
/*lab 111*/

.text
.global _start
	

readL:	MOV X0, 0		//fd =0	 
	ADR x1, empty_arr	//buf= addres empty_arr
	MOV X2, 1		//read 1 byte
	MOV X8, 63		//call read
	SVC 0			//perform read
	Mov X20, 0		//resets the value
	ldr x20, [x1]		//loads and holds the value
	add x24, x24, 1		//increase counter
	cmp x20, 10		//checks if it a endline terminator
	b.eq writer		//go to writer we finished 
	Mov x22, X20		//this is now the character  
	Sub x22, x22, 48	//converts from ascii to int
	cbz x24, mult1		//if the first number don't multilpy by 0
	MUl x25, x25, x21	//multiply the total by 10
	Add x25, X25, x22	//adds new number
	b readL			//loop back
	
writer: Mov x0,x25		//move x25 to x0
	RET			//end
	
mult1:  Mov x25, x22		//just moves value
        b readL			//loops back
_start: 
	Mov x24, -1 		//counter
	Mov x25, 0		//total
	Mov x21, 10		//mov x21 to 10
	bl readL		//loop back
		
	MOV X0, 0		//moves 0
	Mov X8, 93		//calls exit
	SVC 0			//performs exit
.bss  
	empty_arr: .skip 1,0	//holds character
.data


