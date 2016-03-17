public class GenerateInvoicePageExtension{

    ApexPages.StandardController sc;
    public String invoiceID {get;set;}
    public List<Line_Item__c> relatedLineItemList {get;set;}
     
    public GenerateInvoicePageExtension( ApexPages.StandardController sc){
        invoiceID=ApexPages.currentPage().getParameters().get('id');
    } 
    
    public List<Line_Item__c> getRelatedLineItemList(){
        return [select Id,Invoice_Line_Item__c,Item_Name__c,Labour_Cost__c,Service_Fee__c,Tax__c,Total_Amount__c from Line_Item__c where Invoice_Line_Item__c=:invoiceID];
    }
    
    
}