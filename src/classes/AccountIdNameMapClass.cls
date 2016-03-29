public with sharing class AccountIdNameMapClass {
//This method creates a map of account name and account id.
    public static Map<String,ID> createAccountIdNameMap(){
        Map<String,ID> accountNameIdMap=new Map<String,ID>();
        List<Account> accountList=[SELECT ID
                                        , Name 
                                     FROM Account];
        for(Account objAccount: accountList){
            accountNameIdMap.put(objAccount.Name,objAccount .ID);
        }
        return accountNameIdMap;
    }

//This method creates a map of account id as key and account object as value.    
    public static Map<ID,Account> createAccountIdObjectMap(){
        List<Account> accountList=[SELECT ID
                                        , Name
                                        , Phone 
                                     FROM Account];
        Map<ID,Account> accountIdObjectMap=new Map<ID,Account>(accountList);                             
        return accountIdObjectMap;
    }
}