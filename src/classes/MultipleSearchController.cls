public class MultipleSearchController{
    
    public String searchTerm {get;set;}
    public List<Account> accountSearchResult {get;set;}
    public List<Contact> contactSearchResult {get;set;}
    public List<Lead> leadSearchResult {get;set;}
    public List<Opportunity> opportunitySearchResult {get;set;}
    public List<List<Sobject>> searchresult {get;set;}
    
    public MultipleSearchController(){
    
    }
    
    public void performSearch(){
        accountSearchResult=new List<Account>();
        contactSearchResult=new List<Contact>();
        leadSearchResult=new List<Lead>();
        opportunitySearchResult=new List<Opportunity>();
        if(searchTerm.length()>0){
            String finalString='*'+searchTerm+'*';
            String searchQueryString='FIND :finalString IN  NAME FIELDS RETURNING  Account(Name,Phone,PersonEmail__c),Contact(Name,Phone,Email),Lead(Name,Phone,Email),Opportunity(Name,Type,StageName)';
             searchresult=search.query(searchQueryString);
             accountSearchResult=(List<Account>)searchresult[0];
             contactSearchResult=(List<Contact>)searchresult[1];
             leadSearchResult=(List<Lead>)searchresult[2];
             opportunitySearchResult=(List<Opportunity>)searchresult[3];
             if(searchresult[0]==Null && searchresult[1]==Null && searchresult[2]==Null && searchresult[3]==Null){
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'No result found.'));
             }
         }
         else{
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please enter search term first.'));
             return;
         }
        
    }
}