public class PrintActiveUsersClass {
    public void PrintActiveUsers(){
    	Map<ID,User> mapUser=new Map<ID,User>();
		List<User> userList=[select ID,Name,Department from User where IsActive=:True];
		for(User objUser: userList)
		{
    		mapUser.put(objUser.Id,objUser);
		}
		system.debug(mapUSer);
    }
}