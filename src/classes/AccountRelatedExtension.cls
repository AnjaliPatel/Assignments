public class AccountRelatedExtension{

    public AccountRelatedExtension(ApexPages.StandardSetController controller) {

    }

    public String accountIdVar {get;set;}
    public List<Contact> relatedContactList {get;set;}
    public List<Opportunity> relatedOpportunityList {get;set;} 
    
    public AccountRelatedExtension(ApexPages.StandardController sc){
    
    }
    
    public void extractRelatedLists(){
        
        relatedContactList=[SELECT Id
                                 , Name
                                 , Phone
                                 , Email
                              FROM Contact 
                             WHERE AccountId=:accountIdVar ] ;
                             
         relatedOpportunityList=[SELECT Id
                                      , Name
                                      , Type
                                      , StageName
                                   FROM Opportunity
                                  WHERE AccountId=:accountIdVar ]; 
    }
}