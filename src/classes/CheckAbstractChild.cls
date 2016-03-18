public class CheckAbstractChild extends CheckAbstractParent {
    integer sum=0;
    public override void calculatesum(integer a1,integer b1){
        sum=a1+b1;
        system.debug(sum);
    }
}