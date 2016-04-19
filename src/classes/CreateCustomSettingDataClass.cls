//This is the utility class for TestCountryCityCustomSettingPageClass
public class CreateCustomSettingDataClass{
    //This method creates data for Country Custom Setting.
    public static List<Country__c> createCountryCustomSettingData(){
        List<Country__c> countryRecords=new List<Country__c>();
        Country__c record1=new Country__c(Name='India');
        Country__c record2=new Country__c(Name='USA');
        Country__c record3=new Country__c(Name='France');
        countryRecords.add(record1);
        countryRecords.add(record2);
        countryRecords.add(record3);
        insert countryRecords;
        return countryRecords;
    }
    
    //This method creates data for City Custom Setting.
    public static List<City__c> createCityCustomSettingData(){
        List<City__c> cityRecords=new List<City__c>();
        City__c object1=new City__c(Name='New Delhi',Country_Name__c='India');
        City__c object2=new City__c(Name='Pune',Country_Name__c='India');
        City__c object3=new City__c(Name='Mumbai',Country_Name__c='India');
        City__c object4=new City__c(Name='Miami',Country_Name__c='USA');
        City__c object5=new City__c(Name='New York',Country_Name__c='USA');
        City__c object6=new City__c(Name='Paris',Country_Name__c='France');
        City__c object7=new City__c(Name='Lyon',Country_Name__c='France');
        cityRecords.add(object1);
        cityRecords.add(object2);
        cityRecords.add(object3);
        cityRecords.add(object4);
        cityRecords.add(object5);
        cityRecords.add(object6);
        cityRecords.add(object7);
        insert cityRecords;
        return cityRecords;
    }

}