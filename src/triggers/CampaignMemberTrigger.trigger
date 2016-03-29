trigger CampaignMemberTrigger on CampaignMember (before insert,
                                                 before update) {

    if(Trigger.isBefore && Trigger.isInsert){
        CampaignMemberTriggerHandler.AssignVolunteer(Trigger.New);   
    } 
    
    if(Trigger.isBefore && Trigger.isUpdate){
        CampaignMemberTriggerHandler.AssignVolunteer(Trigger.New);
    }
}