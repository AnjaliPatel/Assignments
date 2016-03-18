public with sharing class AccountIdNameMapClass {
    public void createAccountIdNameMap(){
    	Map<String,ID> accountNameIdMap=new Map<String,ID>();
		List<Account> accountList=[select ID,Name from Account];
		for(Account objAccount: accountList){
   	 		accountNameIdMap.put(objAccount.Name,objAccount .ID);
		}
		system.debug(accountNameIdMap);
    }
    
    public void createAccountIdObjectMap(){
    	Map<ID,Account> accountIdObjectMap=new Map<ID,Account>();
		List<Account> accountList=[select ID,Name,Phone from Account];
		for(Account objAccount: accountList){
    		accountIdObjectMap.put(objAccount .ID,objAccount);
		}
		system.debug(accountIdObjectMap);
    }
}