trigger CaseTrigger on Case (before insert) {
    List<Case> caseList=new List<Case>(Trigger.New);
    if(trigger.isBefore && trigger.isInsert)
    {
        CaseTriggerHandler callObject=new CaseTriggerHandler(); 
        callObject.CaseTriggerHandlerMethod(caseList);
    }
}