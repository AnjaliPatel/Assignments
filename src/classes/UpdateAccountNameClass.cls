public with sharing class UpdateAccountNameClass {
    public static void updateAccountName(){
        List<Account> AccountList=[select Id,Name from Account where Name LIKE 'a%'];
        system.debug(AccountList);
        system.debug('No. of account with name starting with A/a are:'+AccountList.size());
        for(Account objAccount:AccountList){
            objAccount.Name='Updated via update DML operation';
        }
        update AccountList;
        system.debug(AccountList);
    }    
}