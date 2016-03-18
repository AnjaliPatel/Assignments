public with sharing class MapAccountOpportunityClass {
//This method creates a map whit Account Id as key and Its Opportunity Id List as value

    public static void MapAccountOpportunity(){
        Map<Id,List<Id>> mapAccountOpportunity=new Map<Id,List<Id>>();
        List<Id> mapValueList=new List<ID>();
        List<Opportunity> AccountIdOpportunityList=[select Id,AccountId from Opportunity];
        for(Opportunity objOpportunity: AccountIdOpportunityList)
        {
            if(mapAccountOpportunity.containskey(objOpportunity.AccountID)){
                mapValueList=mapAccountOpportunity.get(objOpportunity.AccountID);
                mapValueList.add(objOpportunity.Id);
                mapAccountOpportunity.put(objOpportunity.AccountId,mapValueList);
            }
            else{
                mapAccountOpportunity.put(objOpportunity.AccountId,new List<ID>{objOpportunity.Id});
            }
        }
    }
}