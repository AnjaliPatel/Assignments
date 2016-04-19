//This class schedules a batch job that processes all the opportunities closed today and calculates the amount. 
global class CalculateClosedOpportunity implements Database.Batchable<sObject>,Database.Stateful,Schedulable{
    global Double totalAmount=0.0;
    global DateTime startDateTime;
    global DateTime endDateTime;
    public static Integer opportunityCount=0;
    //This is the start method of batchable class which returns the opportunity records which are closed today and are not considered for aggregation.
    global Database.QueryLocator start(Database.BatchableContext BC){
        startDateTime=System.now();
        String selectQuery='SELECT Id,Name,Amount,Is_Aggregated__c FROM Opportunity WHERE StageName IN (\'Closed Won\') AND CreatedDate=Today';
        return Database.getQueryLocator(selectQuery);
    }
    
    //This is the execute method of batchable class that updates the opportunity records and calculate the total amount.
    global void execute(Database.BatchableContext BC, List<Opportunity> closedOpportunityList){
        for(Opportunity obj: closedOpportunityList){
            if(obj.Is_Aggregated__c==false){
                obj.Is_Aggregated__c=true;
                totalAmount+=obj.Amount;
                opportunityCount++;
            }
        }
        update closedOpportunityList;
        system.debug(closedOpportunityList);
    }
    
    //This is the finish method of batchable that formats the email and sends to the owner of opportunity.
    global void finish(Database.BatchableContext BC){
         endDateTime=System.now();
         AsyncApexJob opportunityJob = [SELECT Id
                                             , Status
                                             , NumberOfErrors
                                             , JobItemsProcessed
                                             , TotalJobItems
                                             , CreatedBy.Email
                                          FROM AsyncApexJob 
                                         WHERE Id =:BC.getJobId()];
         Messaging.SingleEmailMessage opportunityMail = new Messaging.SingleEmailMessage();
         String[] recipient = new String[] {opportunityJob.CreatedBy.Email};
         opportunityMail.setToAddresses(recipient);
         opportunityMail.setSubject('Daily Closed Opportunity Amount Update');
         opportunityMail.setPlainTextBody('The batch job for Daily Opportunity Amount Aggregation is completed successfully.'
                                           +'\nThe details associated with the job are as follows:'
                                           +'\nStart Date Time: '+startDateTime
                                           +'\nEnd Date Time: '+endDateTime
                                           +'\nTotal Duration (in Hours): '
                                           +'\nNumber of Opportunities Closed Won Today :'+opportunityJob.TotalJobItems
                                           +'\nTotal Opportunity Amount for today: '+totalAmount);
         Messaging.sendEmail(new Messaging.SingleEmailMessage[] { opportunityMail });
    }
    
    //This method schedules the batch apex job according to cron expression.
    global void execute(SchedulableContext objSchedule){
        CalculateClosedOpportunity opportunityJob=new CalculateClosedOpportunity();
        Id catchJobID=DataBase.executeBatch(opportunityJob);
        /*String cronExpression='0 30 20 ? * MON-FRI';
        String opportunityJobID=System.schedule('Calculate Opportunity Amount',cronExpression, opportunityJob);*/
    }
}