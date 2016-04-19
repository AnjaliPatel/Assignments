//This class tests the batch class CalculateClosedOpportunity
@isTest
public class CalculateClosedOpportunityTest{
    //This testmethod checks the batch job scheduling for 100 Closed today opportunity records
    static testmethod void testBatchOpportunity(){
        Integer countOfJob;
        List<Opportunity> testOpportunityRecords=CreateTestData.opportunityData(100,'Closed Won',50,false);
      
        insert testOpportunityRecords;
        Test.startTest();
        SchedulableContext batchJobSchedule;
        CalculateClosedOpportunity opportunityJob=new CalculateClosedOpportunity();
        String cronExpression='0 30 20 ? * MON-FRI';
        //DataBase.executeBatch(opportunityJob);
        opportunityJob.execute(batchJobSchedule);
        System.schedule('Calculate Opportunity',cronExpression, opportunityJob);
        Test.stopTest();
        List<AggregateResult> opportunityAggregated=[SELECT Count(Id) countAggregate
                                                       FROM Opportunity
                                                      WHERE Is_Aggregated__c=True];
        for(AggregateResult objAggregate: opportunityAggregated){
            countOfJob=(Integer)objAggregate.get('countAggregate');
        }
        System.assertEquals(100,countOfJob);
       // System.assertEquals(5000,opportunityJob.totalAmount);                                                  
    }
    //This testmethod is_aggregated= true condition.
    static testmethod void testAggregatedOpportunity(){
        Integer countOfJob;
        List<Opportunity> testOpportunityRecords=CreateTestData.opportunityData(20,'Closed Won',500,false);
        insert testOpportunityRecords;
        testOpportunityRecords.clear();
        testOpportunityRecords=CreateTestData.opportunityData(20,'Closed Won',500,true);
        insert testOpportunityRecords;
        Test.startTest();
        SchedulableContext batchJobSchedule;
        CalculateClosedOpportunity opportunityJob=new CalculateClosedOpportunity();
        String cronExpression='0 30 20 ? * MON-FRI';
        //DataBase.executeBatch(opportunityJob);
        opportunityJob.execute(batchJobSchedule);
        System.schedule('Calculate Opportunity',cronExpression, opportunityJob);
        Test.stopTest();
        System.assertEquals(20,CalculateClosedOpportunity.opportunityCount);
       // System.assertEquals(5000,opportunityJob.totalAmount);                                                  
    }
}