//This is the helper class for the CampaignMemberTriggerHandler 
public class CampaignMemberTriggerHandlerHelper{
    //This method is a helper method which creates the map of existing records of campaign members.
    public static Map<String,Map<String,Integer>> createExistingCampaignMemberMap(){
        String campaignName=System.Label.Campaign_Name;                                           //Label for name of the campaign
        String roleType=System.Label.Role_Type;
        Map<String,Map<String,Integer>> volunteerCategorisationMap=new Map<String,Map<String,Integer>>();
        Map<String,Integer> cityDistributionMap=new Map<String,Integer>();
        List<AggregateResult> CampaignMemberList=[SELECT COUNT(Name) volunteerCount
                                                       , Campaign_Awareness_Type__c
                                                       , Area__c 
                                                    FROM CampaignMember
                                                   WHERE Participation_Role__c=:roleType
                                                     AND Campaign.Name=:campaignName
                                                     AND Area__c!=Null
                                                GROUP BY Campaign_Awareness_Type__c,Area__c];
                                                
        for(AggregateResult objAggregate: CampaignMemberList)                                    //Creating map of Campaign Awareness Type and City with the volunteer count
        {
            if(volunteerCategorisationMap.containsKey((String)objAggregate.get('Campaign_Awareness_Type__c') )){
                cityDistributionMap=volunteerCategorisationMap.get((String)objAggregate.get('Campaign_Awareness_Type__c'));
                cityDistributionMap.put((String)objAggregate.get('Area__c'),(Integer)objAggregate.get('volunteerCount'));
                volunteerCategorisationMap.put((String)objAggregate.get('Campaign_Awareness_Type__c'),cityDistributionMap);
            }
            else{
                volunteerCategorisationMap.put((String)objAggregate.get('Campaign_Awareness_Type__c'),new Map<String,Integer>{(String)objAggregate.get('Area__c')=>(Integer)objAggregate.get('volunteerCount')});
            }
        }
        system.debug(volunteerCategorisationMap);
        return volunteerCategorisationMap;
    }
}