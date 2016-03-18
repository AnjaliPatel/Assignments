//Class implementing the basic OOPS concepts

public with sharing class BasicProgrammings {

//This method checks whether the input number is a prime number.

    public static Boolean checkPrime(Integer input_no){
        Integer counter;
        for(counter=2;counter<input_no;counter++){
            if(math.mod(input_no,counter)==0){
                return false;
            }
        }
        return true;
    }
    
//This method checks whether input string is pallindrome.
 
    public static Boolean checkPallindrome(string input_string)
    {
        return input_string.equals(input_string.reverse());
    }
    
//This method replaces given character of the string with the input character in array of strings.
    
    public static List<String> replaceCharacter(string stringCharacter, string replacement, List<String> inputStringList)
    {
        List<String> replacedStringList=new List<String>();
        for(String singleString: inputStringList){
            String replacedString=singleString.replace(stringCharacter,replacement);
            replacedStringList.add(replacedString);
        }    
        return replacedStringList;
    }
    
//This method checks the length of input string
  
    public static Integer checkLength(String input_string)
    {
        String[] splitted= input_string.split('');
        Integer counter=0;
        for(String character: splitted){
            counter++;
        }
        return counter;
    }
    
//This method checks that only the unique input should be included
    
    public Set<Integer> unique(Integer[] numbers)
    {
        Set <Integer> uniqueSet = new Set<Integer>();
        for(Integer i:numbers){
            uniqueSet.add(i);
        }
         return uniqueSet;
    }
}