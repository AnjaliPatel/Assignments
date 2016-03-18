public with sharing class AccountMultiSelectPicklist {
//This method extracts accounts with enrollment year=2010
    public static List<Account> extractOneEnrollmentYear(){
        List<Account> oneEnrollmentYear=[select Id,Name,AccountNumber,Enrollment_Year__c from Account where Enrollment_Year__c INCLUDES('2010')];
        return oneEnrollmentYear;
    }
    
//This method extracts accounts with enrollment year as 2013 and 2014
    public static List<Account> extractBothEnrollmentYears(){
        List<Account> twoEnrollmentyears=[select Id,Name,AccountNumber,Enrollment_Year__c from Account where Enrollment_Year__c INCLUDES('2013','2014')];
        return twoEnrollmentyears; 
    }    
}