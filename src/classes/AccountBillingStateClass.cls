public with sharing class AccountBillingStateClass{
//This method retrieves the accounts whose billing state is not Maharashtra and Kerala    
    public static List<Account> RetrieveAccounts(){
        List<Account> accountBillingStateList=[select ID,Name,BillingState from Account where BillingState  NOT IN('Maharashtra','Kerala') ORDER BY BillingState DESC NULLS LAST LIMIT 10000];
        return accountBillingStateList;
    }
}