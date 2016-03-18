public with sharing class RelationshipQueryClass{

//This method retrieves all tha accounts of the active contacts belonging to 'Media' industry
    public static List<Contact> ActiveMediaContactAccounts(){
        return [select ID,Account.Name,Account.Industry from Contact where Account.Active__c IN('Yes') AND Account.Industry IN('Media')];
    }
    
//This method retrieves all records of 'C' with name 'John' along with parent details.
    public static List<Cobject__c> CObjectParentDetails(){
        return [select ID,Name,Name__C,Aobject_MD__r.ID,Aobject_MD__r.Name,Aobject_MD__r.Name__c,Bobject_MD__r.ID,Bobject_MD__r.Name,Bobject_MD__r.Name__c from Cobject__c where Name__c LIKE 'John'];
    }
   
//This method finds all associated contact records of the Account which contains the word 'John'.    
    public static List<Account> AccountHavingJohnContacts(){
        return [select Id,Name, (select Id,Name,AccountId from Contacts) from Account where Name Like'john%' ];
    }
//This method finds all Account records which have at least an opportunity record which is 'Closed Won'
    public static List<Account> AtLeastOneOpporunityAccount(){
        return [select Id,(select AccountId from Opportunities where StageName In('Closed Won')) from Account];
    } 
//This method retrieves all parents with all their child records where in child name is 'John' querying on 'A'.
    public static List<Aobject__c> ParentChildParentRecords(){
        return [select Id,Name__c, (Select Id,Name__c,Bobject_MD__r.ID,Bobject_MD__r.Name,Bobject_MD__r.Name__c from Cobjects__r where Name__c LIKE 'John') from Aobject__c];
    }
}