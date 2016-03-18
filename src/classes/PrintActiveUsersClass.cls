public class PrintActiveUsersClass {
//This method prints the records of active users.
    public static Map<Id,User> PrintActiveUsers(){
        Map<ID,User> mapUser=new Map<ID,User>();
        List<User> userList=[select ID,Name,Department from User where IsActive=:True];
        for(User objUser: userList)
        {
            if(!mapUser.containsKey(objUser.Id))
                mapUser.put(objUser.Id,objUser);
        }
        return mapUser;
    }
}