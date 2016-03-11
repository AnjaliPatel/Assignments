public with sharing class BasicProgrammings {
	public void checkPrime(Integer input_no){
		integer flag=0,counter;
		for(counter=2;counter<input_no;counter++)
		{
			if(math.mod(input_no,counter)==0)
			{
				flag=1;
				break;
			}
		}
		if (flag==0)
		{
			system.debug('Number is prime');
		}
		else
		{
			system.debug('Number is not prime');
		}
		
	}
    
    public void checkPallindrome(string input_string)
    {
    	string revString;
    	boolean result;
    	revString=input_string.reverse();
    	result=input_string.equals(revString);
    	if(result==true)
    	{
    		system.debug('----string is pallindrome');
    	}
    	else
    	{
    		system.debug('----string is not pallindrome.');
    	}
    }
    
    public void replaceCharacter(string charInput, string replaceChar, string input_string)
    {
    	string[] splitted=input_string.split('');
    	//string replacedString;
    	for(integer i=0;i<splitted.size();i++)
    	{
    		if(splitted[i]==replaceChar)
    		{
    			splitted[i]=charInput;
    		}
    	}
    	system.debug(string.valueOf(splitted));
    }
    
 	
 	public void checkLength(String input_string)
 	{
 		String[] splitted= input_string.split('');
 		integer counter=0;
 		for(String character: splitted)
 		{
 			counter++;
 		}
 		system.debug('length of string: '+ counter);
 	}
 	
 	public void unique(integer[] numbers)
 	{
  		Set <Integer> uniqueSet = new Set<Integer>();
  		for(Integer i:numbers)
  		{
   			uniqueSet.add(i);
  		}
 
   			System.debug(uniqueSet);
  	}
}