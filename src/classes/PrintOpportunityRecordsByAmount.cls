public with sharing class PrintOpportunityRecordsByAmount{
//This method retrieves the opportunity records whose amount is greater than 10000 and ordered by created date.
    public static List<Opportunity> retrieveOpportunityRecords(){
        List<Opportunity> OpportunityList=[SELECT ID
                                                , Name
                                                , Amount
                                                , CreatedDate 
                                             FROM Opportunity 
                                            WHERE Amount>10000 
                                              AND (IsDeleted=True
                                               OR  IsDeleted=False)
                                         ORDER BY CreatedDate 
                                           OFFSET 10];
        return OpportunityList;
    }
}