public with sharing class DemoOverrideChild extends DemoOverrideParent {
    
    public override void calculateArea(integer side,integer side2){
        integer area=side*side2;
        system.debug('in child class: area of square: '+ area);
    }
}