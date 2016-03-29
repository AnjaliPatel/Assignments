public with sharing class QuerySearchClass {
//This method demonstrates the use of database.query() method
    public static List<Contact> demoDatabaseQuery(){
        String queryString='SELECT Id,Name,Email FROM Contact WHERE Name!=Null';
        List<Contact> contactList=database.query(queryString);
        return contactList;
    }
    
//This method demonstrates the use of Search class    
    public static List<List<Sobject>> demoDatabaseSearch(){
        String searchString='FIND {"test"} IN NAME FIELDS RETURNING Contact,Account,Lead,User';
        List<List<Sobject>> searchList=search.query(searchString);
        return searchList;
    }
}