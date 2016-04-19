trigger CaseTrigger on Case (before insert) {
    TriggerSetting__c objTriggerSetting=TriggerSetting__c.getInstance(Userinfo.getUserId());
    if(objTriggerSetting.Case_Trigger__c==false)return;
    List<Case> caseList=new List<Case>(Trigger.New);
    if(trigger.isBefore && trigger.isInsert)
    {
        CaseTriggerHandler callObject=new CaseTriggerHandler(); 
        callObject.CaseTriggerHandlerMethod(caseList);
    }
}