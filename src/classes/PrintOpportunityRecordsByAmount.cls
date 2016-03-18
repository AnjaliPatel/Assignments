public with sharing class PrintOpportunityRecordsByAmount{
//This method retrieves the opportunity records whose amount is greater than 10000 and ordered by created date.
    public static List<Opportunity> retrieveOpportunityRecords(){
        List<Opportunity> OpportunityList=[select ID,Name,Amount,CreatedDate from Opportunity where Amount>10000 ORDER BY CreatedDate OFFSET 10];
        return OpportunityList;
    }
}