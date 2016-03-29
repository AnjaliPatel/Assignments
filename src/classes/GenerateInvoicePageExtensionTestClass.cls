//This is the testclass for GenerateInvoicePageExtension
@isTest
public class GenerateInvoicePageExtensionTestClass{
    //This testmethod tests the default entry records of Line Item and Invoice.
    static testmethod void getInvoiceData(){
        Account objAccount=new Account(Name='Anjali');
        insert objAccount;
        Contact objContact=new Contact(LastName='Patel');
        insert objContact;
        Invoice__c objInvoice=new Invoice__c(New_Client__c=true,Related_Account__c=objAccount.Id,Related_Contact__c=objContact.Id);
        insert objInvoice;
        List<Line_Item__c> LineItemList=new List<Line_Item__c>();
        Line_Item__c objLineItem1=new Line_Item__c(Item_Name__c='abc',Labour_Hours__c=4,Service_Fee__c=500,Invoice_Line_Item__c=objInvoice.Id);
        Line_Item__c objLineItem2=new Line_Item__c(Item_Name__c='xyz',Labour_Hours__c=2,Service_Fee__c=1500,Invoice_Line_Item__c=objInvoice.Id);
        LineItemList.add(objLineItem1); 
        LineItemList.add(objLineItem2); 
        insert LineItemList;
       // ApexPages.currentPage().getParameters().put('id',objInvoice.Id);
        ApexPages.StandardController sc;
        Test.startTest();
        GenerateInvoicePageExtension objPage=new GenerateInvoicePageExtension(sc);
        Test.setCurrentPageReference(new PageReference('Page.GenerateInvoicePage'));
        System.currentPageReference().getParameters().put('id',objInvoice.Id);
        Test.stopTest();
    }
    
}