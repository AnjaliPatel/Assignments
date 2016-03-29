//This is the controller class for CountryCityCustomSettingPage
public class CountryCityCustomSettingPageController{
    public String selectedCountryName {get;set;}
    
    public CountryCityCustomSettingPageController(){
    
    }
    //This is the getter method for Country picklist values.
    public List<SelectOption> getCountryValueList(){
        List<SelectOption> countryPicklistValues=new List<SelectOption>();
        countryPicklistValues.add(new SelectOption('','--Select Option--'));
        Map<String,Country__c> countryCustomSettingMap=Country__c.getAll();
        
        List<String> countryNameList=new List<String>();
        countryNameList.addAll(countryCustomSettingMap.keySet());
        countryNameList.sort();
        for(String countryName: countryNameList){
           countryPicklistValues.add(new SelectOption(countryName,countryName)); 
        }
        return countryPicklistValues;
    }
    //This is the getter method for city picklist values according to the selected country.
    public List<SelectOption> getCityValueList(){
        List<SelectOption> cityPicklistValues=new List<SelectOption>();
        cityPicklistValues.add(new SelectOption('','--Cities--'));
        Map<String,City__c> cityCustomSettingMap=City__c.getAll();
        
        Map<String,String> relatedCityMap=new Map<String,String>();
        for(City__c objCity: cityCustomSettingMap.values()){
            if(objCity.Country_Name__c.equals(this.selectedCountryName)){
                relatedCityMap.put(objCity.Name,objCity.Country_Name__c);
            }
        }
        
        List<String> relatedCityList=new List<String>();
        relatedCityList.addAll(relatedCityMap.keySet());
        relatedCityList.sort();
        for(String cityName:relatedCityList){
            cityPicklistValues.add(new SelectOption(cityName,cityName));
        }
        return cityPicklistValues;
    }
}