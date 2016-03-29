//This is the test class for CountryCityCustomSettingPageController 
@isTest
public class TestCountryCityCustomSettingPageClass{
    //This is the test method for TestCountryCityCustomSettingPageClass which takes records of city and country custom settings. 
    public static testmethod void testEntries(){
        List<Country__c> countryTestRecords=createCustomSettingDataClass.createCountryCustomSettingData();
        List<City__c> cityTestRecords=createCustomSettingDataClass.createCityCustomSettingData();
        List<SelectOption> countryValues=new List<SelectOption>();
        List<SelectOption> cityValues=new List<SelectOption>();
        List<SelectOption> city2Values=new List<SelectOption>();
        Test.startTest();                                                                               //Starting Test
        CountryCityCustomSettingPageController objTest=new CountryCityCustomSettingPageController();
        countryValues=objTest.getCountryValueList();
        objTest.selectedCountryName='India';
        cityValues=objTest.getCityValueList();
        system.debug(cityValues);
        objTest.selectedCountryName='USA';
        city2Values=objTest.getCityValueList();
        Test.stopTest();                                                                                //Stopping Test
        system.assertEquals(4,cityValues.size());
        system.assertEquals(3,city2Values.size());
    }
    //This test method checks for the negative country entry.
    public static testmethod void testAbsentCountry(){
        List<Country__c> countryTestRecords=createCustomSettingDataClass.createCountryCustomSettingData();
        List<City__c> cityTestRecords=createCustomSettingDataClass.createCityCustomSettingData();
        List<SelectOption> countryValues=new List<SelectOption>();
        List<SelectOption> cityValues=new List<SelectOption>();
        Test.startTest();                                                                               //Starting Test
        CountryCityCustomSettingPageController objTest=new CountryCityCustomSettingPageController();
        countryValues=objTest.getCountryValueList();
        objTest.selectedCountryName='Sri Lanka';
        cityValues=objTest.getCityValueList();                            
        Test.stopTest();                                                                                 //Stopping Test
        system.assertEquals(1,cityValues.size());
    }
}