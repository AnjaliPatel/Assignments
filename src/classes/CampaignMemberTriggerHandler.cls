//This is the handler class for trigger CampaignMemberTrigger on Campaign Members.
public class CampaignMemberTriggerHandler{
    //This method Accepts the Trigger.New list i.e. the new values of campaign members that are to be inserted and assigns volunteers to teams.
    public static void AssignVolunteer(List<CampaignMember> NewRecord){
        String campaignName=System.Label.Campaign_Name;                                           //Label for name of the campaign
        String roleType=System.Label.Role_Type;                                                   //Label for type of role
        List<ID> contactIdList=new List<ID>();
        List<ID> leadIdList=new List<ID>();
        List<String> InvalidCampaignList=new List<String>();
        
        List<Campaign> objCampaign=[SELECT Id
                                FROM Campaign
                               WHERE Name=:campaignName];
        Map<String,Map<String,Integer>> volunteerCategorisationMap=CampaignMemberTriggerHandlerHelper.createExistingCampaignMemberMap();
        
        system.debug(NewRecord);
        for(CampaignMember objCampaignMember: NewRecord){
            if(objCampaignMember.ContactId!=Null){
                contactIdList.add(objCampaignMember.ContactId);
            }
            else{
                leadIdList.add(objCampaignMember.LeadId);
            }
        }
        
        Map<Id,Contact> contactCampaignMembersMap=new Map<Id,Contact>([SELECT Id
                                                                            , Area__c
                                                                            , Campaign_Awareness_Type__c
                                                                            , Participation_Role__c
                                                                         FROM Contact
                                                                        WHERE ID
                                                                           IN :contactIdList]);
        Map<Id,Lead> leadCampaignMembersMap=new Map<Id,Lead>([SELECT Id
                                                                   , Area__c
                                                                   , Campaign_Awareness_Type__c
                                                                   , Participation_Role__c
                                                                FROM Lead
                                                               WHERE ID
                                                                  IN :leadIdList]);
     try{
        for(CampaignMember objectCampaignMember: NewRecord){
            
            if(objectCampaignMember.ContactId!=Null){
                if(contactCampaignMembersMap.containsKey(objectCampaignMember.ContactId)){
                    Contact objContact=contactCampaignMembersMap.get(objectCampaignMember.ContactId);
                    objectCampaignMember.Area__c=objContact.Area__c;
                    objectCampaignMember.Campaign_Awareness_Type__c=objContact.Campaign_Awareness_Type__c;
                    objectCampaignMember.Participation_Role__c=objContact.Participation_Role__c;
                } 
            }
            else{
                if(leadCampaignMembersMap.containsKey(objectCampaignMember.LeadId)){
                    Lead objLead=leadCampaignMembersMap.get(objectCampaignMember.LeadId);
                    objectCampaignMember.Area__c=objLead.Area__c;
                    objectCampaignMember.Campaign_Awareness_Type__c=objLead.Campaign_Awareness_Type__c;
                    objectCampaignMember.Participation_Role__c=objLead.Participation_Role__c;
                }
            }
            system.debug(objectCampaignMember);
            
            if(objectCampaignMember.Area__c!=Null && objectCampaignMember.Campaign_Awareness_Type__c!=Null && objectCampaignMember.Participation_Role__c!=Null){
                if(objectCampaignMember.CampaignId.equals(objCampaign[0].Id) && objectCampaignMember.Participation_Role__c.equals(roleType)){
                    if(volunteerCategorisationMap.containsKey(objectCampaignMember.Campaign_Awareness_Type__c)){
                        Map<String,Integer> innerMap=volunteerCategorisationMap.get(objectCampaignMember.Campaign_Awareness_Type__c);
                    
                        if(innerMap.containsKey(objectCampaignMember.Area__c)){
                            Integer tempCount=innerMap.get(objectCampaignMember.Area__c);
                        
                            if(tempCount<2){
                                tempCount++;
                                innerMap.put(objectCampaignMember.City,tempCount);
                                volunteerCategorisationMap.put(objectCampaignMember.Campaign_Awareness_Type__c,innerMap);
                            }
                            else{
                                system.debug('.........Team Limit Reached..........');
                                objectCampaignMember.addError('Team Limit has reached. You can register as Participant.'); 
                            }
                        
                        }
                        else{
                            innerMap.put(objectCampaignMember.Area__c,1);
                            volunteerCategorisationMap.put(objectCampaignMember.Campaign_Awareness_Type__c,innerMap);
                        }
                    
                    }
                    else{
                        volunteerCategorisationMap.put(objectCampaignMember.Campaign_Awareness_Type__c,new Map<String,Integer>{objectCampaignMember.Area__c=>1});
                    }                
                } 
                else{
                    objectCampaignMember.addError('Go to Leads/Contacts....And Add the required fields');
                }
            }
            else{
                InvalidCampaignList.add(objectCampaignMember.Name);
                //objectCampaignMember.addError('Required fields-Area,Campaign Awareness type and Role type are empty.');
            }
            system.debug(volunteerCategorisationMap);
        }
    }
    catch(NullPointerException errorMessage){
       // objCampaign[0].addError('Required fields-Area,Campaign Awareness type and Role type are empty.');
    }
        
    }    
}