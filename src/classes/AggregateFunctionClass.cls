public with sharing class AggregateFunctionClass{
//This method calculates the sum of opportunity amount of this fiscal year
    public static Map<Integer,Integer> CurrentFiscalYearOpportunity(){
        List<AggregateResult> OpportunityList=[SELECT fiscalyear
                                                    , sum(amount) totalAmount 
                                                 FROM opportunity 
                                                WHERE closeDate=this_fiscal_year 
                                             GROUP BY fiscalyear];
        Map<Integer,Integer> fiscalYearMap=new Map<Integer,Integer>();
        for(AggregateResult objOpportunity: OpportunityList){
            fiscalYearMap.put((Integer)objOpportunity.get('FiscalYear'),(Integer)objOpportunity.get('totalAmount'));
        }
        return fiscalYearMap;
    }
    
//This method retrieves distinct Lead records of Lead sources having more that 10 leads
    public static List<AggregateResult> DistinctLeadSourceRecords(){
        List<AggregateResult> LeadList=[SELECT COUNT_DISTINCT(ID)
                                             , LeadSource 
                                          FROM Lead 
                                      GROUP BY LeadSource 
                                        HAVING COUNT(ID)>10];
        return LeadList;
    }    

//This method finds total number of Lead records by status by Lead Source
    public static Map<String,Map<String,Integer>> LeadByStatusBySource(){
       List<AggregateResult> LeadRecords=[SELECT Status
                                               , LeadSource
                                               , COUNT(Name) leadCount 
                                            FROM Lead 
                                        GROUP BY Status,LeadSource];
       Map<String,Integer> InnerLeadMap=new Map<String,Integer>();
       Map<String,Map<String,Integer>> LeadStatusSourceMap=new Map<String,Map<String,Integer>>();
       for(AggregateResult objAggregate: LeadRecords)
       {
           if(LeadStatusSourceMap.containsKey((String)objAggregate.get('Status'))){
               InnerLeadMap=LeadStatusSourceMap.get((String)objAggregate.get('Status'));
               InnerLeadMap.put((String)objAggregate.get('LeadSource'),(Integer)objAggregate.get('leadCount'));
               LeadStatusSourceMap.put((String)objAggregate.get('Status'),InnerLeadMap);
           }
           else{
               LeadStatusSourceMap.put((String)objAggregate.get('Status'),new Map<String,Integer>{(String)objAggregate.get('LeadSource')=> (Integer)objAggregate.get('leadCount')});   
           }
       }
       return LeadStatusSourceMap;
    }
}