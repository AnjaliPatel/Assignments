public class AccountRelatedExtension{

    public AccountRelatedExtension(ApexPages.StandardSetController controller) {

    }

    public String accountIdVar {get;set;}
    public List<Contact> relatedContactList {get;set;}
    public List<Opportunity> relatedOpportunityList {get;set;} 
    public Boolean contactRender {get;set;}
    public Boolean opportunityRender {get;set;}
    
    public AccountRelatedExtension(ApexPages.StandardController sc){
        //contactRender=false; 
        //opportunityRender=false; 
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
         if(relatedOpportunityList.size()>0){
             opportunityRender=true; 
         }
         else{
             opportunityRender=false; 
         }
         if(relatedContactList.size()>0){
             contactRender=true; 
         }
         else{
             contactRender=false;
         }
    }
}