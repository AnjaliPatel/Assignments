trigger ContactTrigger on Contact (before insert) {
    TriggerSetting__c objTriggerSetting=TriggerSetting__c.getInstance(Userinfo.getUserId());
    if(objTriggerSetting.Contact_Trigger__c==false)return;
    if(Trigger.isInsert && Trigger.isBefore)
    {
        ContactTriggerHandlerOptimized InitiateHandler=new ContactTriggerHandlerOptimized();
        InitiateHandler.associateAccountToContact(Trigger.New);
    }
    
}