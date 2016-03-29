public with sharing class AccountBillingStateClass{
//This method retrieves the accounts whose billing state is not Maharashtra and Kerala    
    public static List<Account> RetrieveAccounts(){
        List<Account> accountBillingStateList=[SELECT ID
                                                    , Name
                                                    , BillingState 
                                                 FROM Account 
                                                WHERE BillingState  
                                               NOT IN ('Maharashtra','Kerala') 
                                             ORDER BY BillingState 
                                                 DESC 
                                           NULLS LAST 
                                                LIMIT 10000];
        return accountBillingStateList;
    }
}