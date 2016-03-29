public class ManageContactExtension{
    ApexPages.StandardController sc;
    private List<Account> lstAccount=new List<Account>();
    public Integer countAccount;
    public String searchName {get;set;}
    public List<Account> searchList {get;set;}
    public Account objAccount {get;set;}
    public Boolean renderSearchVariable {get;set;}
    public Boolean renderSearchWarning {get;set;}
    
    public ManageContactExtension(ApexPages.StandardController sc){
        
    }
    public List<Account> getLstAccount(){
        return [SELECT Id,Name,PersonEmail__c,Phone,Website FROM Account];
    }
    
    public Integer getCountAccount(){
        return getLstAccount().size();
    }
    
     public void performSearch(){
         String finalString='%'+searchname+'%';
        if(searchName!=Null && (searchName.length()>2) ){
            String queryString='SELECT Id,Name,PersonEmail__c,Phone,Website from Account where Name LIKE :finalString';
            searchList=database.query(queryString);
            renderSearchWarning=false; 
            renderSearchVariable=true;
        }
        else{
            renderSearchWarning=true;
            renderSearchVariable=false;
        } 
    }
    
    public void clearSearch(){
        searchName='';
        searchList.clear(); 
        renderSearchVariable=false; 
    }
}