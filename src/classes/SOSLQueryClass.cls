public with sharing class SOSLQueryClass{
//This method finds 'test' in Accounts,Contacts,Lead and user
    public static List<List<Sobject>> findTestWord(){ 
        return [FIND 'test%' IN NAME FIELDS RETURNING Contact(Id,Name),Account,Lead,User];   
    }
}