public with sharing class CampaignClass {

//This method prints 10 campaign records in ascending and descending order

    public static void orderCampaignRecord(){
        List<Campaign> AscendingCampaignList=[select Id,Name,StartDate,EndDate,Type from Campaign Order By Name LIMIT 10];
        List<Campaign> DescendingCampaignList=[select Id,Name,StartDate,EndDate,Type from Campaign Order By Name DESC LIMIT 10];
        system.debug(AscendingCampaignList);
        system.debug(DescendingCampaignList);
    }
}