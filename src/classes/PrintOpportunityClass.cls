public  class PrintOpportunityClass {
//This method prints the opportunity records with 
//List of ooportunity ids
//Set of Account ids
//Map of Opportunity ids and Account ids

    public static void printOpportunityRecord(){        
        List<Opportunity> listOpportunity=[select ID,AccountId from Opportunity where AccountId != null AND StageName IN ('Closed Won','Closed Lost')];
        List<Id> OpportunityIdList=new List<Id>();
        Set<Id> OpportunityAccountSet=new Set<Id>();
        Map<Id,Id> OpportunityAccountMap=new Map<Id,Id>();
        for(Opportunity objOpportunity:listOpportunity)
        {
            OpportunityIdList.add(objOpportunity.Id);
            OpportunityAccountSet.add(objOpportunity.AccountId);
            if(!OpportunityAccountMap.containsKey(objOpportunity.Id)){
                OpportunityAccountMap.put(objOpportunity.Id,objOpportunity.AccountId);
            }
        }
        system.debug(OpportunityIdList);
        system.debug(OpportunityAccountSet);
        system.debug(OpportunityAccountMap);        
    }
}