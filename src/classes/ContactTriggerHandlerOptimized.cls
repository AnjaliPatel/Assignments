public class ContactTriggerHandlerOptimized{
    public void associateAccountToContact(List<Contact> ContactRecords){
        List<Account> AccountList = [select id,name,Domain__c from Account where Domain__c != NULL];
        System.debug(ContactRecords);
        List<String> emailSplit = new List<String>(); 
        String domain;
        Map<String,List<Contact>> mapDomainContacts = new Map<String,List<Contact>>();
        List<Contact> sameDomainContacts = new List<Contact>();
        
        for(Contact eachContact : ContactRecords){
            if(eachContact.Email != NULL){
                emailSplit = eachContact.Email.split('@');
                domain = emailSplit[1];
                if(mapDomainContacts.containsKey(domain)){
                      sameDomainContacts = mapDomainContacts.get(domain);
                      sameDomainContacts.add(eachContact);
                      mapDomainContacts.put(domain,sameDomainContacts);
                 }
                else{
                    mapDomainContacts.put(domain,new List<Contact>{eachContact});
                }
                
            } 
        }
        System.debug('=========>>>>>>>>>'+mapDomainContacts);
        Id accId;
        for(String key : mapDomainContacts.keySet()){
            List<Contact> eachDomainSet = mapDomainContacts.get(key);
            for(Account eachAccount : AccountList ){
                if(eachAccount.domain__c.contains(key))
                {
                    accId = eachAccount.Id;
                }
                
            }
            for(Contact eachContact : eachDomainSet){
                eachcontact.accountid = accid;
            }mapDomainContacts.put(key,eachDomainSet);
               
        }

    }
}