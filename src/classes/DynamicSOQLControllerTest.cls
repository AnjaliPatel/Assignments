//This class is to test the dynamic Soql page controller.
@isTest
private class DynamicSOQLControllerTest {
	
	//This testmethod checks whether objects are populated in picklist.
    static testMethod void objectPicklistTest() {
        List<SelectOption> objectOptions=new List<SelectOption>();
        DynamicFieldSoqlPageController controlller=new DynamicFieldSoqlPageController();
        Test.startTest();
        objectOptions=controlller.getObjectPickListValues();
        Test.stopTest();
        system.assertNotEquals(0,objectOptions.size());
    }
    
    //This method checks whether selecting an object results in selection of fields.
    static testmethod void fieldMultiPickListTest(){
    	List<SelectOption> objectOptions=new List<SelectOption>();
        DynamicFieldSoqlPageController controlller=new DynamicFieldSoqlPageController();
        Test.startTest();
        objectOptions=controlller.getObjectPickListValues();
        controlller.selectedObject='Contact';
        system.debug(controlller.notSelectedList);
        controlller.extractObjectFields();
        system.debug(controlller.selectedList);
        system.debug(controlller.selectedOptions);
        system.debug(controlller.notSelectedList);
        system.debug(controlller.notSelectedOptions);
        Test.stopTest();
        system.assertEquals(0,controlller.selectedList.size());
        system.assertEquals(0,controlller.selectedOptions.size());
        system.assertNotEquals(0,controlller.notSelectedList.size());
        system.assertNotEquals(0,controlller.notSelectedOptions.size());
    }
    
    //This method checks the adding and removing of valid fields.
    static testmethod void addAndRemoveFields(){
    	List<SelectOption> objectOptions=new List<SelectOption>();
    	Boolean flag=false;
    	Boolean flag1=false;
        DynamicFieldSoqlPageController controlller=new DynamicFieldSoqlPageController();
        Test.startTest();
        objectOptions=controlller.getObjectPickListValues();
        controlller.selectedObject='Contact';
        system.debug(controlller.notSelectedList);
        controlller.extractObjectFields();
        controlller.selectedFields.add('id');
        controlller.selectedFields.add('name');
        controlller.addSelectedFields();
        for(String objselect:controlller.notSelectedList){
        	if(objselect.equals(controlller.selectedFields[0])){
        		flag=true;
        	}
        }
        controlller.notSelectedFields.add('id');
        controlller.removeSelectedFields();
        for(String objselect:controlller.notSelectedList){
            if(objselect.equals(controlller.selectedFields[0])){
                flag1=true;
            }
        }
        Test.stopTest();
        system.assertNotEquals(0,controlller.selectedList.size());
        system.assertNotEquals(0,controlller.selectedOptions.size());
        system.assertNotEquals(0,controlller.notSelectedList.size());
        system.assertNotEquals(0,controlller.notSelectedOptions.size());
        system.assertEquals(false,flag);
        system.assertEquals(true,flag1);
    }
    
    //This testmethod checks the formation of dynamic soql query.
    static testmethod void createSoqlQuery(){
    	List<SelectOption> objectOptions=new List<SelectOption>();
        DynamicFieldSoqlPageController controlller=new DynamicFieldSoqlPageController();
        Test.startTest();
        objectOptions=controlller.getObjectPickListValues();
        controlller.selectedObject='Contact';
        system.debug(controlller.notSelectedList);
        controlller.extractObjectFields();
        controlller.selectedFields.add('id');
        controlller.selectedFields.add('name');
        controlller.addSelectedFields();
        controlller.numberOfRecords=controlller.getNumberOfRecords();
        controlller.orderOptions=controlller.getOrderOptions();
        controlller.selectedRecordNumber='500';
        controlller.executeQuery();
        system.assertEquals('SELECT id,name FROM Contact ORDER BY Id ASC LIMIT 500',controlller.dynamicSoqlQuery);
        system.assertEquals(0,controlller.soqlQueryResults.size());
        controlller.notSelectedFields.add('id');
        controlller.removeSelectedFields();
        controlller.selectedOrder='DESC';
        controlller.selectedRecordNumber='500';
        controlller.executeQuery();
        system.assertEquals('SELECT name FROM Contact ORDER BY Id DESC LIMIT 500',controlller.dynamicSoqlQuery);
        system.assertEquals(0,controlller.soqlQueryResults.size());
        controlller.notSelectedFields.add('name');
        controlller.removeSelectedFields();
        controlller.selectedOrder='DESC';
        controlller.selectedRecordNumber='500';
        controlller.executeQuery();
        system.assertEquals('',controlller.dynamicSoqlQuery);
        system.assertEquals(true,controlller.errorRender);
        system.assertEquals(0,controlller.soqlQueryResults.size());
        Test.stopTest();
        system.assertEquals(0,controlller.selectedList.size());
        system.assertEquals(0,controlller.selectedOptions.size());
        system.assertNotEquals(0,controlller.notSelectedList.size());
        system.assertNotEquals(0,controlller.notSelectedOptions.size());
    }
    
    //This testmethod checks the case when no object is selected.
    static testmethod void noObjectSelected(){
        List<SelectOption> objectOptions=new List<SelectOption>();
        DynamicFieldSoqlPageController controlller=new DynamicFieldSoqlPageController();
        Test.startTest();
        objectOptions=controlller.getObjectPickListValues();
        controlller.selectedObject='';
        controlller.extractObjectFields();
        controlller.numberOfRecords=controlller.getNumberOfRecords();
        controlller.orderOptions=controlller.getOrderOptions();
        controlller.selectedRecordNumber='500';
        controlller.executeQuery();
        Test.stopTest();
        system.assertEquals(0,controlller.selectedList.size());
        system.assertEquals(0,controlller.selectedOptions.size());
        system.assertEquals(0,controlller.notSelectedList.size());
        system.assertEquals(0,controlller.notSelectedOptions.size());
        system.assertEquals('',controlller.dynamicSoqlQuery);
        system.assertEquals(0,controlller.soqlFieldResult.size());
        system.assertEquals(true,controlller.errorRender);
        system.assertEquals(0,controlller.soqlQueryResults.size());
    }
    
    //This testmethod checks the case when there are records present in the selected object.
    static testmethod void recordsPresentForObject(){
    	List<SelectOption> objectOptions=new List<SelectOption>();
    	Contact objContact=new Contact();
    	objContact.FirstName='Anjali';
    	objContact.LastName='Patel';
    	insert objContact; 
        DynamicFieldSoqlPageController controlller=new DynamicFieldSoqlPageController();
        Test.startTest();
        objectOptions=controlller.getObjectPickListValues();
        controlller.selectedObject='Contact';
        controlller.extractObjectFields();
        controlller.numberOfRecords=controlller.getNumberOfRecords();
        controlller.orderOptions=controlller.getOrderOptions();
        controlller.selectedFields.add('id');
        controlller.selectedFields.add('name');
        controlller.addSelectedFields();
        controlller.selectedRecordNumber='500';
        controlller.executeQuery();
        Test.stopTest();
        system.assertEquals('SELECT id,name FROM Contact ORDER BY Id ASC LIMIT 500',controlller.dynamicSoqlQuery);
        system.assertEquals(1,controlller.soqlQueryResults.size());
        
    }
}