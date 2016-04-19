//This class acts as the controller for the DynamicFieldSoqlPage.
public class DynamicFieldSoqlPageController{
    public List<SelectOption> objectPickListValues=new List<SelectOption>();
    public String selectedObject {get;set;}
    public List<SelectOption> notSelectedOptions {get;set;}
    public List<SelectOption> selectedOptions {get;set;}
    public List<String> notSelectedFields {get;set;}
    public List<String> selectedFields {get;set;}
    public Set<String> notSelectedList {get;set;}
    public Set<String> selectedList {get;set;}
    public List<SelectOption> numberOfRecords=new List<SelectOption>(); 
    public String selectedRecordNumber {get;set;}
    public List<SelectOption> orderOptions=new List<SelectOption>();
    public String selectedOrder {get;set;}
    public String dynamicSoqlQuery {get;set;}
    public Boolean errorRender {get;set;}
    public List<sObject> soqlQueryResults {get;set;}
    public List<String> soqlFieldResult {get;set;}
    public Boolean soqlQueryResultRender {get;set;}
    public Boolean recordTableRender {get;set;}
    
    public DynamicFieldSoqlPageController(){
        notSelectedOptions=new List<SelectOption>();
        selectedOptions=new List<SelectOption>();
        notSelectedFields=new List<String>();
        selectedFields=new List<String>();
        notSelectedList=new Set<String>();
        selectedList=new Set<String>();
        soqlFieldResult=new List<String>(); 
        soqlQueryResults=new List<sObject>();
        errorRender=false;
        soqlQueryResultRender=false;
        recordTableRender=false;
    }
    
    //This method generates the options for object picklist.
    public List<SelectOption> getObjectPickListValues(){
        List<Schema.SObjectType> objectList= Schema.getGlobalDescribe().Values();
        List<SelectOption> pickValues=new List<SelectOption>();
        pickValues.add(new SelectOption('','--None--'));
        for(Schema.SObjectType objSchema : objectList){
            if(objSchema.getDescribe().isQueryAble()){
                pickValues.add(new SelectOption(objSchema.getDescribe().getName(),objSchema.getDescribe().getName()));
            }
        }
        pickValues.sort();
        return pickValues;
    }
    
    //This method generates the fields related to the selected object and thus creating the first values for the multipicklist.
    public void extractObjectFields(){
        system.debug(selectedObject);
        notSelectedList.clear();
        selectedList.clear();
        try{
        	Map<String,Schema.sObjectField> objectFieldsMap=Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap();
        	system.debug(objectFieldsMap);
        	notSelectedList.addAll(objectFieldsMap.keyset());
        	system.debug(notSelectedList);
        	createOptions();	
        }
        catch(Exception e){
        	notSelectedOptions.clear();
        	selectedOptions.clear();
        	soqlFieldResult.clear();
        	dynamicSoqlQuery='';
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select the object and fields from picklist.'));
        } 
    }
    
    //This method converts the fields list to a list of options.
    public void createOptions(){
        notSelectedOptions.clear();
        selectedOptions.clear();
        for(String objNotSelect: notSelectedList){
            notSelectedOptions.add(new SelectOption(objNotSelect,objNotSelect));
        }
        for(String objSelect:selectedList){
            selectedOptions.add(new SelectOption(objSelect,objSelect));
        }
    }
    
    //This method is invoked when the add field button is pressed.
    public void addSelectedFields(){
        notSelectedList.removeAll(selectedFields);
        selectedList.addAll(selectedFields);
        createOptions();
    }
    
    //This method is invoked when the remove field button is pressed.
    public void removeSelectedFields(){
        notSelectedList.addAll(notSelectedFields);
        selectedList.removeAll(notSelectedFields);
        createOptions();
    }
    
    //This method gets the option values for the number of records picklist.
    public List<SelectOption> getNumberOfRecords(){
        List<SelectOption> tempNumberList=new List<SelectOption>();
        tempNumberList.add(new SelectOption('500','500'));
        tempNumberList.add(new SelectOption('1000','1000'));
        tempNumberList.add(new SelectOption('5000','5000'));
        tempNumberList.add(new SelectOption('50000','50000'));
        return tempNumberList;
    }
    
    //This method gets the option values for the order radio button.
    public List<SelectOption> getOrderOptions(){
        List<SelectOption> tempOrderValues=new List<SelectOption>();
        tempOrderValues.add(new SelectOption('ASC','Ascending'));
        tempOrderValues.add(new SelectOption('DESC','Descending'));
        return tempOrderValues;
    }
    
    //This method creates the dynamic SOQL query and executes it.
    public void executeQuery(){
        dynamicSoqlQuery='';
        if(selectedList.size()>=1 && selectedObject!=Null){
            errorRender=false;
            dynamicSoqlQuery='SELECT ';
            for(String objSelectedField: selectedList){
                dynamicSoqlQuery=dynamicSoqlQuery+objSelectedField+',';
            }
            dynamicSoqlQuery=dynamicSoqlQuery.removeEnd(',');
            dynamicSoqlQuery=dynamicSoqlQuery+' FROM '+selectedObject;
            if(selectedOrder!=Null){
                dynamicSoqlQuery=dynamicSoqlQuery+' ORDER BY Id '+selectedOrder;
            }
            else{
                dynamicSoqlQuery=dynamicSoqlQuery+' ORDER BY Id ASC';
            }
            dynamicSoqlQuery=dynamicSoqlQuery+' LIMIT '+selectedRecordNumber;
        }
        else{
            errorRender=true;
        }
        soqlFieldResult.clear();
        soqlFieldResult.addAll(selectedList);
        //soqlQueryResults.clear();
        try{
            soqlQueryResults=Database.query(dynamicSoqlQuery);
            system.debug(soqlQueryResults);
            if(soqlQueryResults.size()>0){
                soqlQueryResultRender=false;
                recordTableRender=true;
            }
            else{
                soqlQueryResultRender=true;
                recordTableRender=false;
            }
        }
        catch(Exception e){
            system.debug(e.getMessage());
        }
    }
}