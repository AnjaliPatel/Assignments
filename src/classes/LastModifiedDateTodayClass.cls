public with sharing class LastModifiedDateTodayClass{
//This method retrieves contact records whose last modified date is today
    public static List<Contact> retrievedLastModifiedContacts(){
        List<Contact> ContactList=[select Id,Name,Phone from Contact where LastModifiedDate=Today];
        return ContactList;
    }    
}