@isTest

public class TestContactTrigger{

    static testMethod void runtestContactTrigger(){
        List<Contact> testContactList=new List<Contact>();
        List<Account> testAccountList=new List<Account>();
        Contact Contact1=new Contact(LastName='Patel',Email='patel@gmail.com');
        Contact Contact2=new Contact(LastName='Kakade');
        Contact Contact3=new Contact(LastName='Kumar',Email='kumar@yahoo.com');
        Contact Contact4=new Contact(LastName='Oturkar',Email='oturkar@hotmail.com');
        testContactList.add(Contact1);
        testContactList.add(Contact2);
        testContactList.add(Contact3);
        testContactList.add(Contact4);
        Account Account1=new Account(Name='anjali',Domain__c='gmail.com');
        Account Account2=new Account(Name='saket',Domain__c='yahoo.com');
        testAccountList.add(Account1);
        testAccountList.add(Account2);
        insert testAccountList;
        Test.startTest();
        insert testContactList;
        Test.stopTest(); 
       // Integer queryResult=[SELECT Count(Id) FROM Contact WHERE AccountId!=Null];
        system.assertEquals(1,[SELECT Count(Id) FROM Contact WHERE AccountId!=Null].size());
    }
}