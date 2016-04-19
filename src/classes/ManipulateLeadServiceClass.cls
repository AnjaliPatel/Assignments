@RestResource(urlMapping='/LeadInfo/v1/*')
//This class defines the REST service that creates,deletes and updates a lead on the basis of parameters.
//Base URL= https://ap2.salesforce.com/
global class ManipulateLeadServiceClass {
    
    @HttpPost
    //This POST method creates lead according to the firstname,lastname,email and phone number passed as parameter.
    /*Request Body for insertion of Lead record
        {
          "FirstNameParam":"",
          "LastNameParam":"",  
          "EmailAddress":"",
          "PhoneNumber":"",
          "CompanyName":""
        }
    */
    /*
        Sample input:
        {
            "FirstNameParam":"Rest",
            "LastNameParam":"Method",  
            "EmailAddress":"post@gmail.com",
            "PhoneNumber":"784596321",
            "CompanyName":"salesforce",
        }
    */
    global static LeadResponseWrapper createLead(String FirstNameParam,String LastNameParam,String EmailAddress,String PhoneNumber,String CompanyName) {
        LeadResponseWrapper objResponse=new LeadResponseWrapper();
        Lead objLead = new Lead(
        FirstName=FirstNameParam,
        LastName=LastNameParam,
        Email=EmailAddress,
        Company=CompanyName,
        Phone=PhoneNumber);
        try{
            insert objLead;
            objResponse.IsSuccess=True;
            objResponse.Status='Success';
            objResponse.LeadId=objLead.Id;
            return objResponse;  
            
        }
        catch(Exception e){
            objResponse.IsSuccess=False;
            objResponse.Status=e.getMessage();
            objResponse.LeadId='';
            return objResponse;
        }
    }
    
    @HttpDelete
    //This DELETE method deletes the lead according to the firstname,lastname,phone and email passed as parameters
    ///services/apexrest/LeadInfo/v1?firstname=Rohit&lastname=Kumar&phone=457896311&email=rohit@yahoo.com
    global static LeadResponseWrapper deleteLead(){
        RestRequest objRequest = RestContext.request;
        LeadResponseWrapper objResponse=new LeadResponseWrapper();
        String firstnameVar=objRequest.params.get('firstname');
        String lastNameVar=objRequest.params.get('lastname');
        String phoneVar=objRequest.params.get('phone');
        String emailVar=objRequest.params.get('email');
        if(!String.isEmpty(firstnameVar) && !String.isEmpty(lastNameVar) && !String.isEmpty(phoneVar) && !String.isEmpty(emailVar)){
            try{
                Lead deleteRecord=[SELECT Id
                                        , Name
                                        , Phone
                                        , Email
                                     FROM Lead 
                                    WHERE FirstName=:firstnameVar
                                      AND LastName=:lastNameVar
                                      AND Phone=:phoneVar
                                      AND Email=:emailVar];
                objResponse.IsSuccess=True;
                objResponse.Status='Success';
                objResponse.LeadName=deleteRecord.Name;
                objResponse.LeadId=deleteRecord.Id;
                delete deleteRecord;
                return objResponse;    
            }
            catch(Exception e){
                objResponse.IsSuccess=False;
                objResponse.Status=e.getMessage();
                objResponse.LeadId='';
                return objResponse;
            } 
        }
        else{
            objResponse.IsSuccess=False;
            objResponse.Status='Enter Firstname,Lastname,Phone and Email to delete a record.';
            objResponse.LeadId='';
            return objResponse;
        }
        
    }
    
    @HttpPatch
    //This method takes firstname,lastname,new email and phone as parameters and updates the email and fields of lead.
    /*Request Body for update of Lead record
        {
          "FirstNameParam":"",
          "LastNameParam":"",  
          "EmailAddress":"",
          "PhoneNumber":""
        }
    */
    global static LeadResponseWrapper updateLead(String FirstNameParam,String LastNameParam,String EmailAddress,String PhoneNumber){
        LeadResponseWrapper objResponse=new LeadResponseWrapper();
        String leadIdList='';
        try{
            List<Lead> objLeadList=[SELECT Id
                                         , Name
                                         , Email
                                         , Phone
                                      FROM Lead
                                     WHERE FirstName=:FirstNameParam
                                       AND LastName=:LastNameParam];
            if(!objLeadList.isEmpty()){
                for(Lead objLead: objLeadList){
                    if(!(objLead.Email.equals(EmailAddress) && objLead.Phone.equals(PhoneNumber))){
                        objLead.Email=EmailAddress;
                        objLead.Phone=PhoneNumber;
                        leadIdList=leadIdList+' '+objLead.Id;    
                    }
                    else{
                        objResponse.IsSuccess=False;
                        objResponse.Status='Values for phone and email are same. Change values for update';
                        objResponse.LeadId=objLead.Id;
                        return objResponse;
                    }
                }
                update objLeadList;
                objResponse.IsSuccess=True;
                objResponse.Status='Success';
                objResponse.LeadId=leadIdList;
                return objResponse;
            }
            else{
                objResponse.IsSuccess=False;
                objResponse.Status='No records Found';
                objResponse.LeadId='';
                return objResponse;
            }
        }
        catch(Exception e){
            objResponse.IsSuccess=False;
            objResponse.Status=e.getMessage();
            objResponse.LeadId='';
            return objResponse;
        }
        
    }
    
    //This is the wrapper class for the fields needed in response.
    global class LeadResponseWrapper{
        public Boolean IsSuccess;           //This should be true if operation is successful.
        public String LeadId;               //This contains the Id(s) of the record been processed.
        public String Status;               //This contains 'Success' if the operation was successful, otherwise it contains the error message.
        public String LeadName;             //This contains the name of the Lead.
    }
}