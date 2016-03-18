public with sharing class DMLOperationsClass{

//This method 100 distinct lead records and try to insert them. The records whichc are not inserted should generate error.
    public static void createLeadLogs(){
        List<Lead> LeadList=new List<Lead>();
        for(Integer i=0;i<100;i++)
        {
            if(i<50){
                Lead objLead=new Lead(LastName='Patel'+i,Company='Eternus',Status='Open');
                LeadList.add(objLead);
            }
            else{
                Lead objLead1=new Lead(LastName=''+i,Company='',Status='');
                LeadList.add(objLead1);
            }
        }
        Database.SaveResult[] resultList= Database.insert(LeadList,false);
        for(Database.SaveResult objDatabase: resultList){
            if(objDatabase.isSuccess()){
                system.debug('This record has been inserted successfully: '+objDatabase.getId());
            }
            else{
                for(Database.Error objError: objDatabase.getErrors()){
                    Logs__c objLog=new Logs__c();
                    objLog.Log_Description__c=objError.getMessage();
                    insert objLog;
                    system.debug('Error No.'+objError.getStatusCode()+' : '+objError.getMessage());
                    system.debug('Fields that caused the error: '+objError.getFields());
                }
            }
        }
    }  
    
//This method deletes all inactive Account records created in last 90 days.
    public static void deleteInactiveAccounts(){
        List<Account> AccList=[select Id,Name from Account where Active__c IN('No') AND CreatedDate = LAST_90_DAYS];
        delete accList;
    } 
    
//This method upserts Asset records on basis of external Id field
    public static void upsertAssetRecord(){
        List<Asset> listAsset=new List<Asset>();
        Asset Asset4=new Asset(Name='shashank',ContactId='0032800000HbebD',Line_Item_ID__c='S101');
        Asset Asset3=new Asset(Name='tushar',ContactId='0032800000HbebD',Line_Item_ID__c='A101');
        listAsset.add(Asset3);
        listAsset.add(Asset4);
        upsert listAsset Line_Item_ID__c;
    }    
}