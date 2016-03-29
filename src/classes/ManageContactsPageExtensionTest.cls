@isTest
public class ManageContactsPageExtensionTest{
    static testmethod void getRecordsTest(){
        List<Account> accountList=new List<Account>();
        List<Account> accountRecord=new List<Account>();
        List<Contact> contactList=new List<Contact>();
        List<Contact> contactRecord=new List<Contact>();
        String testAccountId;
        Integer countContact;
        String testContactID;
        
        //accountList=CreateTestData.AccountData();
        Account testAccount = new Account(Name ='Anjali',PersonEmail__c='anjali@gmail.com');
        accountList.add(testAccount);
        insert accountList;
        
        system.debug('---------> Account record: '+accountList);
        ApexPages.CurrentPage().getParameters().put('id',accountList[0].Id);
        ApexPages.StandardController sc;   
        
      /*  contactList=CreateTestData.ContactData();
        for(Integer i=0;i<contactList.size();i++){
            contactList[i].AccountId=accountList[0].ID;
        }*/
        Contact testContact=new Contact(LastName='Kumar',Email='rohit@gmail.com',Phone='125463987',AccountId=accountList[0].Id);
        contactList.add(testContact);
        insert contactList;
        system.debug('---------->Contact Records: '+contactList); 
       // testContactID=contactList[0].Id;
        Test.startTest();
        ManipulateContactExtension objTest1=new ManipulateContactExtension(sc);  
        accountRecord=objTest1.getLstAccount();
        countContact=objTest1.getCountContact();
        Test.stopTest();
        system.assertEquals(1,countContact,'test passed');
        system.assertEquals(1,accountRecord.size());
    }
    //This testmethod is for testing displayAlphabeticalSearch()
    static testmethod void displayAllSearch(){
        List<Account> accountList=new List<Account>();
        List<Account> accountRecord=new List<Account>();
        List<Contact> contactList=new List<Contact>();
        List<Contact> contactRecord=new List<Contact>();
        String testAccountId;
        Integer countContact;
        String testContactID;
        Account testAccount = new Account(Name ='Anjali',PersonEmail__c='anjali@gmail.com');
        accountList.add(testAccount);
        insert accountList;
        system.debug('---------> Account record: '+accountList);
        //ApexPages.CurrentPage().getParameters().put('id',accountList[0].Id);
        Contact testContact=new Contact(LastName='Kumar',Email='rohit@gmail.com',Phone='125463987',AccountId=accountList[0].Id);
        contactList.add(testContact);
        insert contactList;
        ApexPages.StandardController sc;  
        Test.startTest();
        ManipulateContactExtension objTest1=new ManipulateContactExtension(sc);  
        accountRecord=objTest1.getLstAccount();
        countContact=objTest1.getCountContact();
        objTest1.alphabetVar='All';
        objTest1.displayAlphabeticalSearch(); 
        Test.stopTest();
        system.assertEquals(1,objTest1.lstContact.size());
    }
    //This testmethod is for testing single alphabet search
    static testmethod void displaySinglesearch(){
        List<Account> accountList=new List<Account>();
        List<Account> accountRecord=new List<Account>();
        List<Contact> contactList=new List<Contact>();
        Integer countContact;
        String testContactID;
        Account testAccount = new Account(Name ='Anjali',PersonEmail__c='anjali@gmail.com');
        accountList.add(testAccount);
        insert accountList;
        Contact testContact=new Contact(FirstName='Rohit',LastName='Kumar',Email='rohit@gmail.com',Phone='125463987',AccountId=accountList[0].Id);
        contactList.add(testContact);
        insert contactList;
        ApexPages.StandardController sc;  
        Test.startTest();
        ManipulateContactExtension objTest1=new ManipulateContactExtension(sc);  
        accountRecord=objTest1.getLstAccount();
        countContact=objTest1.getCountContact();
        objTest1.alphabetVar='R';
        objTest1.displayAlphabeticalSearch(); 
        Test.stopTest();
        system.assertEquals(1,objTest1.lstContact.size());
    }
    //This testmethod tests the case of zero search result
    static testmethod void displayZeroSearch(){
        List<Account> accountList=new List<Account>();
        List<Account> accountRecord=new List<Account>();
        List<Contact> contactList=new List<Contact>();
        Integer countContact;
        String testContactID;
        Account testAccount = new Account(Name ='Anjali',PersonEmail__c='anjali@gmail.com');
        accountList.add(testAccount);
        insert accountList;
        Contact testContact=new Contact(FirstName='Rohit',LastName='Kumar',Email='rohit@gmail.com',Phone='125463987',AccountId=accountList[0].Id);
        contactList.add(testContact);
        insert contactList;
        ApexPages.StandardController sc;  
        Test.startTest();
        ManipulateContactExtension objTest1=new ManipulateContactExtension(sc);  
        accountRecord=objTest1.getLstAccount();
        countContact=objTest1.getCountContact();
        objTest1.alphabetVar='B';
        objTest1.displayAlphabeticalSearch(); 
        Test.stopTest();
        system.assertEquals(0,objTest1.lstContact.size());
    } 
    //This testmethod is for testing the delete all method.
    static testmethod void deleteAllContacts(){
        List<Account> accountList=new List<Account>();
        List<Account> accountRecord=new List<Account>();
        List<Contact> contactList=new List<Contact>();
        Account testAccount = new Account(Name ='Anjali',PersonEmail__c='anjali@gmail.com');
        accountList.add(testAccount);
        insert accountList;
        ApexPages.CurrentPage().getParameters().put('id',accountList[0].Id);
        Contact testContact=new Contact(FirstName='Rohit',LastName='Kumar',Email='rohit@gmail.com',Phone='125463987',AccountId=accountList[0].Id);
        contactList.add(testContact);
        insert contactList;
        ApexPages.StandardController sc;  
        Test.startTest();
        ManipulateContactExtension objTest1=new ManipulateContactExtension(sc);  
        accountRecord=objTest1.getLstAccount();
        objTest1.deleteAll();
        Test.stopTest();
        system.assertEquals(0,objTest1.lstContact.size());
    }
}