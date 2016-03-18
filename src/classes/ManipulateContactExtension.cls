global class ManipulateContactExtension{
    ApexPages.StandardController sc;
    public List<Account> lstAccount=new List<Account>();
    public List<Contact> lstContact {get;set;}
    public String currentId {get;set;}
    public List<Contact> delContact=new List<Contact>();
    public Integer countContact; 
    public String delContactId {get;set;}
    public List<String> alphabetList {get;set;}
    public String alphabetVar {get;set;}  
    public List<Contact> displayContactList {get;set;}
  
    public ManipulateContactExtension(ApexPages.StandardController sc){ 
        currentId=ApexPages.currentPage().getParameters().get('id');
        alphabetList=new List<String>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','All'};
        alphabetVar='All'; 
        displayContactList=new List<Contact>([select Id,Name,Phone,Email from Contact where AccountId=:currentId ORDER BY Name ]); 
        lstContact=new List<Contact>();
        for(Contact objContact: displayContactList){
            if(alphabetVar.equals('All')){
                lstContact.add(objContact);
            }
            else{
                if((objContact.Name.startsWith(alphabetVar)) || (objContact.Name.startsWith(alphabetVar.toLowerCase()))){
                    lstContact.add(objContact);
                }
            }
        }  
    }
    
    public List<Account> getLstAccount(){
        return [select Id,Name from Account where Id=:currentId ];
    }
    
    public Integer getCountContact(){
        return lstContact.size();
    }
     
    public pageReference deleteAll(){
        try{
            List<Contact> delContact=new List<Contact>(lstContact);
            delete(delContact);
            PageReference deleteref=new PageReference('/apex/ManageAccountPage');
            return deleteref;
        }
        catch(exception e)
        {
            return null;
        }    
    }
    
     public pageReference deleteSingle(){
        try{
            system.debug(delContactId);
            List<Contact> delContactSingle=new List<Contact>([select Id,Name from Contact where Id=:delContactId]);
            delete(delContactSingle);
            return null;
         }
        catch(exception e)
        {
            return null;
        }    
    }
    
    
    public void displayAlphabeticalSearch(){
        lstContact.clear();
        system.debug(alphabetVar);
        for(Contact objContact: displayContactList){
            if(alphabetVar.equals('All')){
                lstContact.add(objContact);
            }
            else{
                if((objContact.Name.startsWith(alphabetVar)) || (objContact.Name.startsWith(alphabetVar.toLowerCase()))){
                    lstContact.add(objContact);
                }
            }
        }  
        system.debug(lstContact);
    }
    
    @RemoteAction
    global static String deleteSingle(String delContactId){
            List<Contact> delContactSingle=new List<Contact>([select Id,Name from Contact where Id=:delContactId]);
            delete(delContactSingle);
            String successMessage='Deletion Completed';
            return successMessage;
        }
    
}