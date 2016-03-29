public class GenerateInvoicePageExtension{

    ApexPages.StandardController sc;
    public String invoiceID {get;set;}
    public List<Line_Item__c> relatedLineItemList=new List<Line_Item__c>();
    public Double totalBillAmount {get;set;}
     
    public GenerateInvoicePageExtension( ApexPages.StandardController sc){
        invoiceID=ApexPages.currentPage().getParameters().get('id');     
    } 
    
    public List<Line_Item__c> getRelatedLineItemList(){
        return [SELECT Id
                     , Invoice_Line_Item__c
                     , Item_Name__c
                     , Labour_Cost__c
                     , Service_Fee__c
                     , Tax__c
                     , Total_Amount__c 
                  FROM Line_Item__c 
                 WHERE Invoice_Line_Item__c=:invoiceID];
    }
    
    public Double getTotalBillAmount(){
      /*  AggregateResult[] objSum=[select sum(Total_Amount__c) billTotal from Line_Item__c where Invoice_Line_Item__c=:invoiceID GROUP BY Invoice_Line_Item__c];
        system.debug(objSum[0]);
        system.debug((Double)objSum[0].get('billTotal'));
        return (Double)objSum[0].get('billTotal');*/
        Double billAmount;
        for(Line_Item__c objLineItem: relatedLineItemList){
            billAmount+= objLineItem.Total_Amount__c ;
            system.debug(billAmount);
        }
        return billAmount;
    }
}