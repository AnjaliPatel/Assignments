public class DynamicSOQLPageController{
    
    public List<SelectOption> objectPickListValues=new List<SelectOption>() ;
    public List<SelectOption> multiSelectPickValues=new List<SelectOption>();
    public String selectedObject {get;set;}
    public List<String> selectedFieldValues {get;set;}
    public List<String> selectedMultiFieldValues {get;set;}
    public List<SelectOption> selectedFieldOptions {get;set;}
    public Boolean multipickRender {get;set;}
    public List<SelectOption> numberOfRecords=new List<SelectOption>(); 
    public String selectedRecordNumber {get;set;}
    public List<SelectOption> orderOptions=new List<SelectOption>();
    public String selectedOrder {get;set;}
    public String dynamicSoqlQuery {get;set;}
    
    public DynamicSOQLPageController(){
        multipickRender=false;
    }
    
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
    
    public List<SelectOption> getMultiSelectPickValues(){
        List<SelectOption> fieldPickValues=new List<SelectOption>();
        //fieldPickValues.add(new SelectOption('','--None--'));
        //selectedObject='Account';
        if(!String.isEmpty(selectedObject )){
            Map<String,Schema.sObjectField> objectFieldsMap=Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap();
            system.debug(objectFieldsMap);
            for(String fieldName: objectFieldsMap.keySet()){
                fieldPickValues.add(new SelectOption(fieldName,fieldName));
            }
            return fieldPickValues;
        }
        else{
            fieldPickValues.add(new SelectOption('','--Select An Object--'));
            return fieldPickValues;
        }
    }
    
    public void createSelectedFieldOptions(){
        //List<SelectOption> valueForSelectedFieldsList=new List<SelectOption>();
        //system.debug(selectedFieldValues);
        selectedFieldOptions=new List<SelectOption>();
        if(selectedFieldValues.isEmpty()){
            selectedFieldOptions.add(new SelectOption('','---Select Fields---'));
            system.debug(selectedFieldOptions);
            multipickRender=true; 
        //    return valueForSelectedFieldsList;
        }
        else{
            for(String objSelected: selectedFieldValues){
                selectedFieldOptions.add(new SelectOption(objSelected,objSelected));
            }
            system.debug(selectedFieldOptions);
            multipickRender=true; 
           // return valueForSelectedFieldsList;
        }
    }
    
    public List<SelectOption> getNumberOfRecords(){
        List<SelectOption> tempNumberList=new List<SelectOption>();
        tempNumberList.add(new SelectOption('500','500'));
        tempNumberList.add(new SelectOption('1000','1000'));
        tempNumberList.add(new SelectOption('5000','5000'));
        tempNumberList.add(new SelectOption('50000','50000'));
        return tempNumberList;
    }
    
    public List<SelectOption> getOrderOptions(){
        List<SelectOption> tempOrderValues=new List<SelectOption>();
        tempOrderValues.add(new SelectOption('ASC','Ascending'));
        tempOrderValues.add(new SelectOption('DESC','Descending'));
        dynamicSoqlQuery='SELECT '+selectedFieldValues+' FROM '+ selectedObject +' ORDER BY '+selectedOrder+' LIMIT '+ selectedRecordNumber  ;
        return tempOrderValues;
    }
}