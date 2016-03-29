public with sharing class RelationshipQueryClass{

//This method retrieves all tha accounts of the active contacts belonging to 'Media' industry
    public static List<Contact> ActiveMediaContactAccounts(){
        return [SELECT ID
                     , Account.Name
                     , Account.Industry 
                  FROM Contact 
                 WHERE Account.Active__c
                    IN ('Yes') 
                   AND Account.Industry 
                    IN ('Media')];
    }
    
//This method retrieves all records of 'C' with name 'John' along with parent details.
    public static List<Cobject__c> CObjectParentDetails(String searchName){
        return [SELECT ID
                     , Name
                     , Name__C
                     , Aobject_MD__r.ID
                     , Aobject_MD__r.Name
                     , Aobject_MD__r.Name__c
                     , Bobject_MD__r.ID
                     , Bobject_MD__r.Name
                     , Bobject_MD__r.Name__c 
                  FROM Cobject__c 
                 WHERE Name__c=:searchName];
    }
   
//This method finds all associated contact records of the Account which contains the word 'John'.    
    public static List<Account> AccountHavingJohnContacts(){
        return [select Id
                     , Name
                     , 
               (SELECT Id
                     , Name
                     , AccountId 
                  FROM Contacts) 
                  FROM Account 
                 WHERE Name 
                  LIKE '%john%' ];
    }
//This method finds all Account records which have at least an opportunity record which is 'Closed Won'
    public static List<Account> AtLeastOneOpporunityAccount(){
        return [SELECT Id
                     ,
               (SELECT AccountId 
                  FROM Opportunities 
                 WHERE StageName 
                    IN ('Closed Won')) 
                  FROM Account];
    } 
//This method retrieves all parents with all their child records where in child name is 'John' querying on 'A'.
    public static List<Aobject__c> ParentChildParentRecords(){
        return [select Id,Name__c, (SELECT Id
                                         , Name__c
                                         , Bobject_MD__r.ID
                                         , Bobject_MD__r.Name
                                         , Bobject_MD__r.Name__c 
                                      FROM Cobjects__r 
                                     WHERE Name__c 
                                      LIKE 'John') 
                                      FROM Aobject__c];
    }
}