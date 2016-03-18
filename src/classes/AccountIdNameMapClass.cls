public with sharing class AccountIdNameMapClass {
//This method creates a map of account name and account id.
    public static Map<String,ID> createAccountIdNameMap(){
        Map<String,ID> accountNameIdMap=new Map<String,ID>();
        List<Account> accountList=[select ID,Name from Account];
        for(Account objAccount: accountList){
            accountNameIdMap.put(objAccount.Name,objAccount .ID);
        }
        return accountNameIdMap;
    }

//This method creates a map of account id as key and account object as value.    
    public static Map<ID,Account> createAccountIdObjectMap(){
        Map<ID,Account> accountIdObjectMap=new Map<ID,Account>();
        List<Account> accountList=[select ID,Name,Phone from Account];
        for(Account objAccount: accountList){
            accountIdObjectMap.put(objAccount .ID,objAccount);
        }
        return accountIdObjectMap;
    }
}