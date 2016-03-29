public with sharing class AccountController
{
    Apexpages.StandardController controller;
    public AccountController(Apexpages.StandardController c)
    {
        controller = c;
    }
 
    public PageReference save() 
    {
        controller.save();//invoke standard Save method
        Id Pageid = ApexPages.currentPage().getParameters().get('id');
        String url = 'https://ap2.salesforce.com/apex/TwoStepWizardAccountUpdatePage?id='+Pageid;
        PageReference newpage=new PageReference(url);
        return newpage;//refresh current page
    }
 }