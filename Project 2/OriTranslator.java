//Kush Parmar
//I pledge my honor that i have abided by the stevens honor system.
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.ArrayList;

public abstract class OriTranslator {
	public static String [] two_Bits = {"00","01","10","11"};
	public static String [] address= {"00:","10:","20:","30:","40:","50:","60:","70:","80:","90:"
			,"a0:","b0:","c0:","d0:","e0:","f0:"};
	public static String [][] hexAddress= new String[16][16];
	public static ArrayList<String> instructions= new ArrayList<String>();

	public static void initalize() {
		//sets up the matrix that is going to be written
		for(int i =0; i<hexAddress.length; i++) {
			for(int j =0; j<hexAddress[i].length;j++) {
				hexAddress[i][j]="00";
			}
		}
	}
	public static String ImmediateToBinary(String num_to_translate) {
		// This function is only ran if you are loading
		// I mean there are only 3 possible values so....
		int num=  Integer.parseInt(num_to_translate);
		if(num==-2) {
			return two_Bits[2];
		}
		else if(num==-1) {
			return two_Bits[3];
		}
		else if(num==0) {
			return two_Bits[0];
		}
		else {
			return two_Bits[1];
		}
	}
	public static String AluOpToBinary(String aluOp_Translate) {
		//again there are only 4 functions ldr, add, and, nop
		//so as a dumb way to write this is if statements
		if(aluOp_Translate.equalsIgnoreCase("ldr")) {
			return two_Bits[3];
		}
		else if(aluOp_Translate.equalsIgnoreCase("add")) {
			return two_Bits[1];
		}
		else if(aluOp_Translate.equalsIgnoreCase("and")) {
			return two_Bits[2];
		}
		else if(aluOp_Translate.equalsIgnoreCase("nop")) {
			return two_Bits[0];
		}
		else {
			return two_Bits[0];
		}
	}
	public static String RegisterToBinary(String reg_Translate) {
		//returns the register number in binary
		String crop=""+reg_Translate.charAt(1); //getting rid of the x
		int num=  Integer.parseInt(crop);
		return two_Bits[num];
	}
	 
	public static void BinaryToHex(){
		/* this was a painful process of decoding a string
		 the way this is done is by realizing that in my syntax we would 
		 always have 3 commas. Since there are only 3 commas, we just need
		 to be concerned by where the commas are.
		 
		 We just take each instruction found in the arraylist instructions
		 and convert to binary (using the function above) which is 
		 converted to hex and stored into a matrix which is to be written.
		*/
		int index_counter=-1;
		String output="";
		// int [] find_comma= new int [4];
		// int find_comma_index=1;
		for(String it: instructions) {
			String each = it.replaceAll("\\s", "");
			String[] split_Each = each.split(",", 4);
				output+=AluOpToBinary(split_Each[0]);
				if(output.equals(two_Bits[3])){
					output+=ImmediateToBinary(split_Each[1]);
					output+=RegisterToBinary(split_Each[2]);
					output+=RegisterToBinary(split_Each[3]);
				}
				else{
					output+=RegisterToBinary(split_Each[1]);
					output+=RegisterToBinary(split_Each[2]);
					output+=RegisterToBinary(split_Each[3]);
				}
		outer: for(int i =0; i<hexAddress.length;i++) {
				for(int j=0; j<hexAddress[i].length;j++) {
					if(hexAddress[i][j].equals("00")&&((i*16)+j)>index_counter){
						hexAddress[i][j]=helper_BinaryToHex(output);
						break outer;
					}
				}
			}
			index_counter++;
			output="";
		}
	}
	public static String helper_BinaryToHex(String binary){
		int num= Integer.parseInt(binary, 2);
		String hexConvert= Integer.toHexString(num);
		if (hexConvert.length()==1) {
			String append_zero_beginning=binary.substring(0,4);
			String append_zero_ending=binary.substring(4, binary.length());
			if(append_zero_beginning.equals("0000")){
				hexConvert="0"+hexConvert;
			}
			else if(append_zero_ending.equals("0000")){
				hexConvert+="0";
			}
		}
		return hexConvert;
	}
	public static void Writeback(String path) {
		BufferedWriter bw = null;
		try {
		   String mycontent ="";
		    
		   File file = new File(path);

		   //checks to see if there is a file name translated
		   //else it creates one
		   if (!file.exists()) {
			   file.createNewFile();
			   }
		   		FileWriter fw = new FileWriter(file);
				bw = new BufferedWriter(fw);
				bw.write("v3.0 hex words addressed\r\n"	+ "");
				for(int i = 0;i<hexAddress.length;i++) {
					mycontent+=address[i]+" ";
					for(int j=0; j<hexAddress[i].length;j++) {
						if(j==15) {
							mycontent+=hexAddress[i][j]+"\r\n";
						}
						else {
							mycontent+=hexAddress[i][j]+" ";
						 }
					  }
					  bw.write(mycontent);
					  mycontent="";
				  }	  
			} catch (IOException ioe) {
			   ioe.printStackTrace();
			}
			finally
			{ 
			   try{
			      if(bw!=null)
				 bw.close();
			   }catch(Exception ex){
			       System.out.println("Error in closing the BufferedWriter"+ex);				    }
			}
	}
	public static void main(String[] args) throws FileNotFoundException {
	    Scanner in = new Scanner(System.in);  // Create a Scanner object
	    System.out.println("Insert path for the toTranslate.txt (exclude \\toTranslate.txt at the end of the path)");
	    String path= in.nextLine();
		initalize(); //sets up matrix
	    File fileReader = new File(path+"\\toTranslate.txt");
	    BufferedReader reader=null;
	    try {
	    	 reader = new BufferedReader(new FileReader(fileReader));
	    }
	    catch(FileNotFoundException e){
	 	    	Writeback(path);
	 	    	try {
	 	    		fileReader.createNewFile();
	 	    	}
	 	    	catch(IOException ioe) {
	 			   ioe.printStackTrace();
	 	    	}
	 	    	throw new FileNotFoundException ("Created File add instructions to toTranslate.txt");
	    }
		String each_Instruction =null;
		try {
			while((each_Instruction=reader.readLine())!=null) {
				instructions.add(each_Instruction);
			}
		}catch (IOException ex) {
	        ex.printStackTrace();
	    }
		BinaryToHex();
		Writeback(path+"\\translated");
		System.out.println("You can now insert translated file into the instruction memory in Project2.circ file");
	}
}

