//This is the handler class for contact trigger 
public class ContactTriggerHandlerOptimized{
    //This method associates account with same domain with the inserted contacts.
    public void associateAccountToContact(List<Contact> ContactRecordList){
        
        List<Account> AccountRecordList=[SELECT ID
                                             , Name
                                             , Domain__c
                                          FROM Account 
                                         WHERE Domain__c!=Null];
        Map<String,Id> AccountDomainIdMap=new Map<String,Id>();
        for(Account objAccount: AccountRecordList){
            AccountDomainIdMap.put(objAccount.Domain__c,objAccount.Id);
        }
        List<String> splitEmail=new List<String>();
        String CompareDomain;
        for(Contact Toassociate: ContactRecordList){
            if(Toassociate.Email != NULL){
                splitEmail=Toassociate.Email.split('@');
                CompareDomain=splitEmail[1];
                if(AccountDomainIdMap.containsKey(CompareDomain)){
                    Toassociate.AccountId=AccountDomainIdMap.get(CompareDomain);
                }
             }   
        }       

    }
}