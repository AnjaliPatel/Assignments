public with sharing class PrintContactRecordClass {
//This method prints the records of contacts    
    public static List<Contact> PrintContactRecord(){
        List<Contact> contactList= [SELECT ID
                                         , Name
                                         , Email
                                         , Phone 
                                      FROM Contact
                                     WHERE Name!=NULL];
        return contactList; 
    }
}