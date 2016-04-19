trigger createCloneTrigger on Lead (after insert) {
     TriggerSetting__c objTriggerSetting=TriggerSetting__c.getInstance(Userinfo.getUserId());
    if(objTriggerSetting.Create_Clone_Lead_Trigger__c==false)return;
    List<Lead> LeadList=new List<Lead>(Trigger.new);
    List<Lead> cloneRecord=new List<Lead>();
    for(Lead objLead:LeadList){
        Lead cloneRecordObj= objLead.clone(false,false,true,true);
        cloneRecord.add(cloneRecordObj);
        if(checkRecursion.checkTriggerExecution()){
            insert cloneRecord;
            system.debug('clone created');
        }
    }    
}