public with sharing class PrintContactRecordClass {
    public void PrintContactRecord(){
    	List<Contact> contactList= [select ID,Name from Contact];
		System.debug(contactList);	
    }
}