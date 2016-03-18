trigger ContextVariableTrigger on Account (after update,before insert ) {
                                
    if(trigger.isBefore && trigger.isInsert)
    {
        system.debug('For new ' + Trigger.New);
    }
    if(trigger.isAfter && trigger.isUpdate)
    {
        system.debug('For newMAp ' + Trigger.newMap);
        system.debug('For old ' + Trigger.old);
        system.debug('For oldMAp ' + Trigger.oldMap);
    }
}