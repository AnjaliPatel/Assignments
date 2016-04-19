//This class tests the REST web service ManipulateLeadServiceClass
@isTest
public class ManipulateLeadServiceClassTest{
   
    //This testmethod tests the successful insertion of the Lead record.
    static testmethod void testSuccessfulInsert(){
        RestRequest objRequest = new RestRequest();
        objRequest.requestUri='https://ap2.salesforce.com/services/apexrest/LeadInfo/v1/*';
        objRequest.httpMethod = 'POST';
        objRequest.addHeader('Content-Type', 'application/json');
        //objRequest.requestBody = Blob.valueOf('{ "FirstNameParam":"Anjali","LastNameParam":"Patel","EmailAddress":"anju@gmail.com","PhoneNumber":"75482361","CompanyName":"Eternus"}'); 
        RestContext.request = objRequest;
        ManipulateLeadServiceClass.LeadResponseWrapper objResponse=new ManipulateLeadServiceClass.LeadResponseWrapper();
        objResponse=ManipulateLeadServiceClass.createLead('Anjali','Patel','anju@gmail.com','75482361','Eternus');
        system.assertEquals('Success',objResponse.Status); 
        system.assertEquals(true,objResponse.IsSuccess); 
        system.assertNotEquals('',objResponse.LeadId); 
    }
    
    //This testmethod tests the unsuccessful insertion of the Lead record.
    static testmethod void testUnSuccessfulInsert(){
        RestRequest objRequest = new RestRequest();
        objRequest.requestUri='https://ap2.salesforce.com/services/apexrest/LeadInfo/v1/*';
        objRequest.httpMethod = 'POST';
        objRequest.addHeader('Content-Type', 'application/json');
        RestContext.request = objRequest;
        ManipulateLeadServiceClass.LeadResponseWrapper objResponse=new ManipulateLeadServiceClass.LeadResponseWrapper();
        try{
            objResponse=ManipulateLeadServiceClass.createLead('Anjali','Patel','anju@gmail.com','75482361','');
        }
        catch(Exception e){
            e.getMessage();
        }
        system.assertEquals('Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [Company]: [Company]',objResponse.Status); 
        system.assertEquals(False,objResponse.IsSuccess); 
        system.assertEquals('',objResponse.LeadId); 
    }
    
    //This testmethod tests the successful Delete operation on leads.
    static testmethod void testSuccessfulDelete(){
        List<Lead> leadTestRecord=CreateTestData.leadData(1,'Rohit','Kumar','rohit@yahoo.com','457896311','abc');
        insert leadTestRecord;
        List<Lead> leadInserted=[SELECT Id
                                      , Name
                                      , Email
                                      , Phone
                                      , Company
                                   FROM Lead];
        RestRequest objRequest = new RestRequest();
        RestContext.request = objRequest;
        objRequest.requestUri='https://ap2.salesforce.com/services/apexrest/LeadInfo/v1?';
        objRequest.params.put('firstname','Rohit');
        objRequest.params.put('lastname','Kumar');
        objRequest.params.put('phone','457896311');
        objRequest.params.put('email','rohit@yahoo.com');
        objRequest.httpMethod = 'DELETE';
        objRequest.addHeader('Content-Type', 'application/json');
        
        ManipulateLeadServiceClass.LeadResponseWrapper objResponse=new ManipulateLeadServiceClass.LeadResponseWrapper();
        Test.startTest();
        objResponse=ManipulateLeadServiceClass.deleteLead();
        List<Lead> leadDeleted=[SELECT Id
                                     , Name
                                     , Email
                                     , Phone
                                     , Company
                                  FROM Lead];
        Test.stopTest();
        system.assertEquals('Success',objResponse.Status); 
        system.assertEquals(true,objResponse.IsSuccess); 
        system.assertEquals(leadInserted[0].Id,objResponse.LeadId); 
        system.assertEquals(0,leadDeleted.size());
        system.assertEquals(1,leadInserted.size());
    }
    
    //This testmethod checks the unsuccessful delete operation.
    static testmethod void testUnSuccessfulDelete(){
        List<Lead> leadTestRecord=CreateTestData.leadData(1,'Rohit','Kumar','rohit@yahoo.com','457896311','abc');
        insert leadTestRecord;
        List<Lead> leadInserted=[SELECT Id
                                      , Name
                                      , Email
                                      , Phone
                                      , Company
                                   FROM Lead];
        RestRequest objRequest = new RestRequest();
        RestContext.request = objRequest;
        objRequest.requestUri='https://ap2.salesforce.com/services/apexrest/LeadInfo/v1?';
        objRequest.params.put('firstname','Rohit');
        objRequest.params.put('lastname','Kumar');
        objRequest.params.put('phone','457896311');
        objRequest.httpMethod = 'DELETE';
        objRequest.addHeader('Content-Type', 'application/json');
        ManipulateLeadServiceClass.LeadResponseWrapper objResponse=new ManipulateLeadServiceClass.LeadResponseWrapper();
        Test.startTest();
        try{
            objResponse=ManipulateLeadServiceClass.deleteLead();
        }
        catch(Exception e){
            e.getMessage();
        }
        List<Lead> leadDeleted=[SELECT Id
                                     , Name
                                     , Email
                                     , Phone
                                     , Company
                                  FROM Lead];
        system.assertEquals('Enter Firstname,Lastname,Phone and Email to delete a record.',objResponse.Status); 
        system.assertEquals(False,objResponse.IsSuccess); 
        system.assertEquals('',objResponse.LeadId); 
        system.assertEquals(1,leadDeleted.size());
        objRequest.params.put('firstname','Nikeet');
        objRequest.params.put('lastname','Kumar');
        objRequest.params.put('phone','457896311');
        objRequest.params.put('email','rohit@yahoo.com');
        try{
            objResponse=ManipulateLeadServiceClass.deleteLead();
        }
        catch(Exception e){
            e.getMessage();
        }
        List<Lead> leadsDeleted=[SELECT Id
                                     , Name
                                     , Email
                                     , Phone
                                     , Company
                                  FROM Lead];
        //system.assertEquals(e.getMessage(),objResponse.Status); 
        system.assertEquals(False,objResponse.IsSuccess); 
        system.assertEquals('',objResponse.LeadId); 
        system.assertEquals(1,leadsDeleted.size());
        Test.stopTest();
    }
    
    //This testmethod checks the successful update operation.
    static testmethod void testSuccessfulUpdate(){
        List<Lead> leadTestRecord=CreateTestData.leadData(1,'Rohit','Kumar','rohit@yahoo.com','457896311','abc');
        insert leadTestRecord;
        List<Lead> leadInserted=[SELECT Id
                                      , Name
                                      , Email
                                      , Phone
                                      , Company
                                   FROM Lead];
        RestRequest objRequest = new RestRequest();
        objRequest.requestUri='https://ap2.salesforce.com/services/apexrest/LeadInfo/v1/*';
        objRequest.httpMethod = 'PATCH';
        objRequest.addHeader('Content-Type', 'application/json');
        RestContext.request = objRequest;
        ManipulateLeadServiceClass.LeadResponseWrapper objResponse=new ManipulateLeadServiceClass.LeadResponseWrapper();
        Test.startTest();
        objResponse=ManipulateLeadServiceClass.updateLead('Rohit','Kumar','anju@gmail.com','75482361');
        system.assertEquals('Success',objResponse.Status); 
        system.assertEquals(true,objResponse.IsSuccess); 
        system.assertNotEquals('',objResponse.LeadId); 
        objResponse=ManipulateLeadServiceClass.updateLead('Nikeet','Kumar','anju@gmail.com','75482361');
        system.assertEquals('No records Found',objResponse.Status); 
        system.assertEquals(False,objResponse.IsSuccess); 
        system.assertEquals('',objResponse.LeadId); 
        objResponse=ManipulateLeadServiceClass.updateLead('Rohit','Kumar','anju@','75482361');
        system.assertEquals('Update failed. First exception on row 0 with id '+leadInserted[0].Id+'; first error: INVALID_EMAIL_ADDRESS, Email: invalid email address: anju@: [Email]',objResponse.Status); 
        system.assertEquals(False,objResponse.IsSuccess); 
        system.assertEquals('',objResponse.LeadId); 
        Test.stopTest();
    }
}