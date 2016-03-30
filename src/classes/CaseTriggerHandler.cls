//This is the handler class for the case trigger.
public class CaseTriggerHandler{
    //This method accepts the recently inserted records of cases through web,email and chat and assigns account to them.
    public void CaseTriggerHandlerMethod(List<Case> caseList){
        List<Account> accountList=[SELECT Id
                                        , Name
                                        , PersonEmail__c 
                                     FROM Account 
                                    WHERE RecordTypeId 
                                       IN (SELECT Id 
                                             FROM RecordType 
                                            WHERE Name='Person Account')];
        Map<String,Id> accountEmailIdMap=new Map<String,Id>();
        for(Account objAccount: accountList){
            accountEmailIdMap.put(objAccount.PersonEmail__c,objAccount.Id);
        }
        for(Case objCase: caseList){
            if(accountEmailIdMap.containsKey(objCase.SuppliedEmail)){
                objCase.AccountId=accountEmailIdMap.get(objCase.SuppliedEmail);
            }        
        }
    }
}