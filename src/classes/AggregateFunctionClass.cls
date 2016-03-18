public with sharing class AggregateFunctionClass{
//This method calculates the sum of opportunity amount of this fiscal year
    public static List<AggregateResult> CurrentFiscalYearOpportunity(){
        List<AggregateResult> OpportunityList=[select fiscalyear,sum(amount) from opportunity where closeDate=this_fiscal_year group by fiscalyear];
        return OpportunityList;
    }
    
//This method retrieves distinct Lead records of Lead sources having more that 10 leads
    public static List<AggregateResult> DistinctLeadSourceRecords(){
        List<AggregateResult> LeadList=[select COUNT_DISTINCT(ID),LeadSource from Lead GROUP BY LeadSource HAVING COUNT(ID)>10];
        return LeadList;
    }    

//This method finds total number of Lead records by status by Lead Source
    public static Map<String,Map<String,Integer>> LeadByStatusBySource(){
       List<AggregateResult> LeadRecords=[select Status,LeadSource,count(Name) leadCount from Lead group by Status,LeadSource];
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