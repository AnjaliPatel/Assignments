trigger CheckAllActionsTrigger on Account (after delete,
                                            after insert, 
                                            after undelete, 
                                            after update, 
                                            before delete, 
                                            before insert, 
                                            before update ) {
     TriggerSetting__c objTriggerSetting=TriggerSetting__c.getInstance(Userinfo.getUserId());
    if(objTriggerSetting.Check_All_Actions_Account_Trigger__c==false)return;
                                
    if(trigger.isBefore && trigger.isInsert)
    {
        system.debug('For before insert: new ' + Trigger.New);
    }
    if(trigger.isAfter && trigger.isInsert)
    {
        system.debug('For after insert : newMap ' + Trigger.newMap);
    }
    if(trigger.isBefore && trigger.isUpdate)
    {
        system.debug('For before update:old ' + Trigger.old);
    }
    if(trigger.isAfter && trigger.isUpdate)
    {
        system.debug('For after update:newMap ' + Trigger.newMap);
    }
    if(trigger.isBefore && trigger.isDelete)
    {
        system.debug('For before delete:old ' + Trigger.old);
    }
    if(trigger.isAfter && trigger.isDelete)
    {
        system.debug('For after delete: oldMap ' + Trigger.oldMap);
    }
    if(trigger.isAfter && trigger.isUndelete)
    {
        system.debug('For after undelete: OldMap ' + Trigger.New);
    }
}