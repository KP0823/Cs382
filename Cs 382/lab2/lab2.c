#include <stdio.h>
#include <stdlib.h>

//Kush Parmar
//I pledge my honor that I have abided by the stevens honor system-Kush
void display(int8_t bit) {
    putchar(bit + 48);
}

void display_32(int32_t num) {
    int bitwiseRight=0;
    //For loop way
    /*
    for(int i = 31; i>=0; i--){
    	bitwiseRight= num>>i;
     	display(bitwiseRight&1);
    }
    printf("\n");
    */
    int counter = 31;
    Loop: bitwiseRight = num>>counter;
    	if(counter>=0){
    		display(bitwiseRight&1);
    		counter--;
    		goto Loop;
    	}
    	else{
    		printf("\n");
    	}

}

int main(int argc, char const *argv[]) {
    display_32(1993);
    display_32(382);

    return 0;
}
