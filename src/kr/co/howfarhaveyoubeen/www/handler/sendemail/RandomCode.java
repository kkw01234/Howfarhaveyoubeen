package kr.co.howfarhaveyoubeen.www.handler.sendemail;

import java.util.Random;

public class RandomCode {
	
	public String Code() {
		
		char[] charaters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9'};
  	    StringBuffer sb = new StringBuffer();
   	    Random rn = new Random();

 	    for( int i = 0 ; i < 5 ; i++ ){
 	       sb.append( charaters[ rn.nextInt( charaters.length ) ] );
 	    }
		 
 	    String checkCode = sb.toString();
		
 	    return checkCode;
	}

}
