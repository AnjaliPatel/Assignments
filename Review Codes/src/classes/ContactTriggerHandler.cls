public class ContactTriggerHandler{
    public void AssociateContactToAccount(List<Contact> ContactRecordList){
        
        List<Account> AccountList=[select ID,Name,Domain__c from Account];
        List<String> splitEmail=new List<String>();
        String CompareDomain;
        for(Contact Toassociate: ContactRecordList)
        {
            if(Toassociate.Email != NULL)
            {
                splitEmail=Toassociate.Email.split('@');
                CompareDomain=splitEmail[1];
                for(Account checkDomain: AccountList)
                {
                    if(CompareDomain==checkDomain.Domain__c)
                    {
                        Toassociate.AccountId=checkDomain.ID;
                    }
                }
             }   
        }    
    }
}