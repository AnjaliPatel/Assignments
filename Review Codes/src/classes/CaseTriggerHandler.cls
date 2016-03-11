public class CaseTriggerHandler{
    public void CaseTriggerHandlerMethod(List<Case> caseList){
        List<Account> AccountList=[select Id,Name,PersonEmail__c from Account where RecordTypeId IN(select Id from RecordType where Name='Person Account')];
        for(Account AccObject: AccountList)
        {
            for(Case CaseObject: caseList)
            {
                if(CaseObject.Origin=='Web'|| CaseObject.Origin=='Email' )
                {
                    if(AccObject.PersonEmail__c==CaseObject.SuppliedEmail)
                    {
                        CaseObject.AccountId=AccObject.Id;
                    }
                }
            }
        }
    
    }
}