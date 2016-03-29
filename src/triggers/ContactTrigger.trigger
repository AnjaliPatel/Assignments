trigger ContactTrigger on Contact (before insert) {
    TriggerSetting__c objTriggerSetting=TriggerSetting__c.getInstance();
    if(objTriggerSetting.Contact_Trigger__c==true){ 
    if(Trigger.isInsert && Trigger.isBefore)
    {
        ContactTriggerHandlerOptimized InitiateHandler=new ContactTriggerHandlerOptimized();
        InitiateHandler.associateAccountToContact(Trigger.New);
    }
    }
}