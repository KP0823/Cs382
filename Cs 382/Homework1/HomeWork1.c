#include <stdio.h>

/*
	Kush parmar 
	I pledge my honor that I have abided by the stevens honor system-Kush Parmar
	INSERTION SORT- EXTRA CREDIT APPLICABLE 

*/
void strcpy(char* src, char* dst){
	int counter= 0; //interating index for the for the go to loop
	char insert; //char variable that will hold char that will be added char*dst
	Loop_Str_Copy: 
		insert=(* (src+counter)); //insert equals pointer's character
		if((*(src+counter))!='\0'){  //checks for null terminator
			(*(dst+counter))=insert; //adds insert to dst
			counter++; //increases interator
			goto Loop_Str_Copy;
		}
}
int dot_prod(char* vec_a, char* vec_b, int length, int size_elem) {
	int counter= 0; //interating index for the go to loop
	int total=0; // returning total, the dot product
	int var_a; // vector one variable
	int var_b; //vector two variable
	Loop_Dot_Product:
		if(counter<length){
			var_b=*((int*) ((vec_b+(counter*size_elem)))); //casting a single element vec_a
			var_a=*((int*) ((vec_a+(counter*size_elem)))); //casting a single element vec_b
			total+=(var_b*var_a);  //adding to total
			counter++; //increment index
			goto Loop_Dot_Product; 
		}
	return total;
}

void insertionSort(unsigned int * arr, int n){ //algromith from cs:281
	int i=1;
	unsigned int key;
	int j;
	LoopFor:
		if(i<n){
			key= arr[i];
			j=i-1;

			LoopWhile:
				if(j>=0 &&arr[j]>key){
					arr[j+1]= arr[j];
					j=j-1;
					goto LoopWhile;
				}
			arr[j+1]=key;
			i++;
			goto LoopFor;
		}
}

void sort_nib(int* arr,int length){
    int counter =0; //interates arr
	int size_array=(length*sizeof(arr)); //calulations for the size of the array of hexdemical bits
	int holder= (((sizeof(arr)-1)*(sizeof(int)))); //the max bits too shift- left/right
	unsigned int array_of_bits [size_array];  //array for new bit hexidecimal 
	int i=0; //interates array_of_bits
	int j=0;// interates the amount of bits shifting
	
	Loops_for:
		if(counter<length){
			Loops_inner_for:
				if(j<=holder){
            		array_of_bits[i]= ((((unsigned int) arr[counter])<<j) >>holder); //shifts bits to grab single bit
            		i++;	
					j+=4;
					goto Loops_inner_for;
				}
			counter++;
			j=0;
			goto Loops_for;
		}

	insertionSort(array_of_bits,size_array); //sorts array_of_bits
	i=0; //this holds the place in the array_of_bits
	j=holder; //this hold the byte movement index
	counter=0; //iterates through arr
	unsigned int combine=0; // new combined address that will modified
	loop_set_arr:
		if(counter<length){  
			if(j>=0){
				combine=(array_of_bits[i]<<j)|combine; //inserts hexidecimal bits 
				i++;
				j-=4;
				goto loop_set_arr;			
			}
			arr[counter]=(int)combine;// modifies arr
			combine=0;
			j=holder;
			counter++;
			goto loop_set_arr;
		}
} 
int main(){
	char str1[] = "382 is the best!";
    char str2[100] = {0};
	strcpy(str1, str2);
	puts(str1);
    puts(str2);
	
	int vec_a[3] = {12,34,10};
 	int vec_b[3] = {10,20,30};
 	int dot = dot_prod((char*)vec_a, (char*)vec_b, 3, sizeof(int));
	printf("%d\n", dot);

	int arr[3] = {0x12BFDA09, 0x9089CDBA, 0x56788910};
	sort_nib(arr,3);
	for (int i = 0; i < 3; i ++) {
		printf("0x%08x ", arr[i]);
	}
 	puts("");

	return 0;
}