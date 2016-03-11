public class testclass {
    public static void calculatePercent (Student__c[] students) {
        for (Student__c s :students){
         s.Percent_Acquired__c = (s.Marks__c/700)*100;
    }
   } 
}