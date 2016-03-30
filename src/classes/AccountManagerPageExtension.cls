public class AccountManagerPageExtension{
    ApexPages.StandardController objController;
  //  public String inputEmail {get;set;}
  //  public Boolean errorRender {get;set;}
    
    public AccountManagerPageExtension(ApexPages.StandardController sc){
        objController=sc;
  //      errorRender=false;
    } 

    public pageReference createAccount(){
            objController.save();
            PageReference pageRef=new PageReference('/apex/ManageAccountPage'); 
            pageRef.setRedirect(true);
            return pageRef;
    }
}