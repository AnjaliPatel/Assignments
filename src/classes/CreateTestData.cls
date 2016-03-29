public class CreateTestData{
    //This is a utility method to create test data for account object.
    public static List<Account> AccountData(){
        Account acc1=new Account(Name='anjali',PersonEmail__c='anjali@gmail.com',Phone='125463987',Website='');
        Account acc2=new Account(Name='ashwini',PersonEmail__c='ashu@gmail.com',Phone='546354987',Website='');
        List<Account> AccList=new List<Account>();
        AccList.add(acc1);
        AccList.add(acc2);
        insert AccList; 
        return AccList;              
    }
    //This is a utility method to create test data for contact object.
    public static List<Contact> ContactData(){
        Contact contact1=new Contact(LastName='Patel',Email='anjali@gmail.com',Phone='125463987');
        Contact contact2=new Contact(LastName='Kumar',Email='rohit@gmail.com',Phone='125463987');
        List<Contact> ConList=new List<Contact>();
        ConList.add(contact1);
        ConList.add(contact1);
        return ConList;              
    }
}