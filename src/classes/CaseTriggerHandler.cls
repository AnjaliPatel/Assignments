public class CaseTriggerHandler{
    public void CaseTriggerHandlerMethod(List<Case> caseList){
        List<Account> AccountList=[SELECT Id
                                        , Name
                                        , PersonEmail__c 
                                     FROM Account 
                                    WHERE RecordTypeId 
                                       IN (SELECT Id 
                                             FROM RecordType 
                                            WHERE Name='Person Account')];
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