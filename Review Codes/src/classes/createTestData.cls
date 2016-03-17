public class createTestData{
    public static List<Account> AccountData(){
        Account acc1=new Account(Name='anjali',PersonEmail__c='anjali@gmail.com',Phone='125463987',Website='');
        Account acc2=new Account(Name='ashwini',PersonEmail__c='ashu@gmail.com',Phone='546354987',Website='');
        List<Account> AccList=new List<Account>();
        AccList.add(acc1);
        AccList.add(acc2);
        insert AccList; 
        return AccList;              
    }

}