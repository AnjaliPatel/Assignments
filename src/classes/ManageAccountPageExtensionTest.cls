@isTest
public class ManageAccountPageExtensionTest{
    static testmethod void ManageContactExtensionTest(){
        List<Account> accountList=new List<Account>();
        List<Account> accountRecord=new List<Account>();
        Integer countAccount;
        
        accountList=CreateTestData.AccountData();
        system.debug(accountList);
        ApexPages.StandardController sc;
        
        Test.startTest();
        ManageContactExtension objTest=new ManageContactExtension(sc);  
        accountRecord=objTest.getLstAccount();
        countAccount=objTest.getCountAccount();
        Test.stopTest();
        system.assertEquals(2,countAccount);
    }
    
    static testmethod void searchTest(){
         List<Account> accountList=new List<Account>();
         List<Account> accountRecord=new List<Account>();
         List<Account> searchList=new List<Account>();
         String searchName;
         accountList=CreateTestData.AccountData();
         ApexPages.StandardController sc;
         
         Test.startTest();
         ManageContactExtension objTest=new ManageContactExtension(sc);  
         accountRecord=objTest.getLstAccount();
         objTest.searchName='anjali';
         objTest.performSearch();
         Test.stopTest();
         system.assertEquals(1,objTest.searchList.size());
    }
    
    static testmethod void emptySearchTest(){
         List<Account> accountList=new List<Account>();
         List<Account> accountRecord=new List<Account>();
         List<Account> searchList=new List<Account>();
         String searchName;
         accountList=CreateTestData.AccountData();
         ApexPages.StandardController sc;
         
         Test.startTest();
         ManageContactExtension objTest=new ManageContactExtension(sc);  
         accountRecord=objTest.getLstAccount();
         objTest.searchName='an';
         objTest.performSearch();
         Test.stopTest();
         system.assertEquals(false,objTest.renderSearchVariable);
    }
    
    static testmethod void ClearSearchTest(){
         List<Account> accountList=new List<Account>();
         List<Account> accountRecord=new List<Account>();
         List<Account> searchList=new List<Account>();
         String searchName;
         accountList=CreateTestData.AccountData();
         ApexPages.StandardController sc;
         
         Test.startTest();
         ManageContactExtension objTest=new ManageContactExtension(sc);  
         accountRecord=objTest.getLstAccount();
         objTest.searchName='anjali';
         objTest.performSearch();
         objTest.clearSearch();
         Test.stopTest();
         system.assertEquals(0,objTest.searchList.size());
    }
}