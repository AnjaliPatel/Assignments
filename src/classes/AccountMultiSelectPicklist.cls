public with sharing class AccountMultiSelectPicklist {
    public void extractEnrollmentYear(){
    	List<Account> oneEnrollmentYear=[select Id,Name,AccountNumber,Enrollment_Year__c from Account where Enrollment_Year__c INCLUDES('2010')];
    	List<Account> twoEnrollmentyears=[select Id,Name,AccountNumber,Enrollment_Year__c from Account where Enrollment_Year__c INCLUDES('2013','2014')];
    	system.debug('Accounts having enrollment year 2010:'+oneEnrollmentYear);
    	system.debug('Accounts having enrollment year 2013 and 2014: '+twoEnrollmentyears);
    }
}