public class CustomTextManipulationPageController{
    public String languageCode {get;set;}
    
    public CustomTextManipulationPageController(){
    }
    
    public List<SelectOption> getLanguageList(){
        List<SelectOption> languagePickValue=new List<SelectOption>();
        Map<String,Language__c> LanguageCustomSettingMap=Language__c.getAll();
        List<String> LanguageList=new List<String>();
        LanguageList.addAll(LanguageCustomSettingMap.keySet());
        LanguageList.sort();
        for(String LanguageName: LanguageList){
           languagePickValue.add(new SelectOption(LanguageCustomSettingMap.get(LanguageName).Language_Code__c,LanguageName)); 
        }
        return languagePickValue; 
    }
}