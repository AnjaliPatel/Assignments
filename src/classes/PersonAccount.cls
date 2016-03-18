public with sharing class PersonAccount{
 
//This method prints the person accounts using traditional and advanced for loop
    public static void printPersonAccount(){
         List<Account> personAccountList=[select Id,Name from Account where RecordTypeID=:'01228000000GWlhAAG'];
        for(Integer i=0;i<personAccountList.size();i++){
            system.debug(personAccountList[i]);
        }
        for(Account objAccount: personAccountList){
            system.debug(objAccount);
        }
    }
}