public with sharing class PrintContactRecordClass {
//This method prints the records of contacts    
    public static List<Contact> PrintContactRecord(){
        List<Contact> contactList= [select ID,Name,Email,Phone from Contact];
        return contactList; 
    }
}