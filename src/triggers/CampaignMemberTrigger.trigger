trigger CampaignMemberTrigger on CampaignMember (before insert,
                                                 before update) {
    TriggerSetting__c objTriggerSetting=TriggerSetting__c.getInstance(Userinfo.getUserId());
    if(objTriggerSetting.Campaign_Trigger__c==false)return;
    if(Trigger.isBefore && Trigger.isInsert){
        CampaignMemberTriggerHandler.AssignVolunteer(Trigger.New);   
    } 
    
    if(Trigger.isBefore && Trigger.isUpdate){
        CampaignMemberTriggerHandler.AssignVolunteer(Trigger.New);
    }
}