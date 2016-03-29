trigger createCloneTrigger on Lead (after insert) {
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