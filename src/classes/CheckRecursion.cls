public class CheckRecursion{

    public static boolean flag=true;
    public static boolean checkTriggerExecution(){
    
        if(flag)
        {
            flag=false;
            return true;
        }
        else
        {
            return flag;
        }
    }
}