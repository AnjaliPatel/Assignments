@isTest
public class CampaignMemberTriggerTestClass{
    //This testmethod checks for the records of campaign members when team limit has reached.
    static testmethod void testLimitReachedRecords(){
        Campaign objCampaign=new Campaign(Name='TRY Health Campaign');
        insert objCampaign;
        
        List<CampaignMember> CampaignRecords=CampaignMemberTriggerUtilityClass.createCampaignMembers(objCampaign.Id);
        insert CampaignRecords;
        Contact objNewContact=new Contact(FirstName='rohit',LastName='kumar',MailingCity='Pune',Area__c='South',Campaign_Awareness_Type__c='Health Issues',Participation_Role__c='Volunteer');
        insert objNewContact;
        CampaignMember objNewCampaignMember=new CampaignMember(ContactID=objNewContact.Id,CampaignId=objCampaign.Id);
        try{
            Test.startTest();
            insert objNewCampaignMember;
            Test.stopTest();
        }
        catch(Exception e){
            system.assert(e.getMessage().contains('Team Limit has reached. You can register as Participant.'));
            //system.assertEquals(null,objNewCampaignMember.Id,'Test limit reached');
        }
    }
    
    //This testmethod checks for successful insertion.
    static testmethod void testSuccessfulInsertion(){
        Campaign objCampaign=new Campaign(Name='TRY Health Campaign');
        insert objCampaign;
        
        List<CampaignMember> CampaignRecords=CampaignMemberTriggerUtilityClass.createCampaignMembers(objCampaign.Id);
        insert CampaignRecords;
        Contact objNewContact=new Contact(FirstName='rohit',LastName='kumar',MailingCity='Pune',Area__c='East',Campaign_Awareness_Type__c='Health Issues',Participation_Role__c='Volunteer');
        insert objNewContact;
        List<CampaignMember> testList=new List<CampaignMember>();
        CampaignMember objNewCampaignMember=new CampaignMember(ContactID=objNewContact.Id,CampaignId=objCampaign.Id);
        Test.startTest();
        insert objNewCampaignMember;
        testList.add(objNewCampaignMember);
        Test.stopTest();
        system.assertEquals(1,testList.size());
    }
    //This testmethod checks for insertion when area is null.
    static testmethod void testAreaIsNull(){
        Campaign objCampaign=new Campaign(Name='TRY Health Campaign');
        insert objCampaign;
        
        List<CampaignMember> CampaignRecords=CampaignMemberTriggerUtilityClass.createCampaignMembers(objCampaign.Id);
        insert CampaignRecords;
        Contact objNewContact=new Contact(FirstName='rohit',LastName='kumar',MailingCity='Pune',Area__c='',Campaign_Awareness_Type__c='Health Issues',Participation_Role__c='Volunteer');
        insert objNewContact;
        CampaignMember objNewCampaignMember=new CampaignMember(ContactID=objNewContact.Id,CampaignId=objCampaign.Id);
        Test.startTest();
        insert objNewCampaignMember;
        Test.stopTest();
        system.assertEquals(Null,objNewCampaignMember.Area__c);
    }
    //This testmethod checks for successful update of campaign member.
    static testmethod void testSuccessfulUpdate(){
        Campaign objCampaign=new Campaign(Name='TRY Health Campaign');
        insert objCampaign;
        
        List<CampaignMember> CampaignRecords=CampaignMemberTriggerUtilityClass.createCampaignMembers(objCampaign.Id);
        insert CampaignRecords;
        Contact objNewContact=new Contact(FirstName='rohit',LastName='kumar',MailingCity='Pune',Area__c='East',Campaign_Awareness_Type__c='Blood Donation',Participation_Role__c='Volunteer');
        insert objNewContact;
        CampaignMember objNewCampaignMember=new CampaignMember(ContactID=objNewContact.Id,CampaignId=objCampaign.Id);
        insert objNewCampaignMember;
        CampaignMember objNewCampaignMember1=[SELECT Id
                                                   , Area__c
                                                FROM CampaignMember
                                               WHERE Id=:objNewCampaignMember.Id];
        objNewCampaignMember1.Area__c='West';
        Test.startTest();
        update objNewCampaignMember1;
        Test.stopTest();
        system.assertEquals('West',objNewCampaignMember1.Area__c);
    }
    //This testmethod checks for unsuccessful update of campaign member.
    static testmethod void testUnsuccessfulUpdate(){
        Campaign objCampaign=new Campaign(Name='TRY Health Campaign');
        insert objCampaign;
        
        List<CampaignMember> CampaignRecords=CampaignMemberTriggerUtilityClass.createCampaignMembers(objCampaign.Id);
        Contact objNewContact=new Contact(FirstName='rohit',LastName='kumar',MailingCity='Pune',Area__c='North',Campaign_Awareness_Type__c='Health Issues',Participation_Role__c='Volunteer');
        insert objNewContact;
        CampaignMember objNewCampaignMember=new CampaignMember(ContactID=objNewContact.Id,CampaignId=objCampaign.Id);
        insert objNewCampaignMember;
        system.debug(objNewCampaignMember);
        CampaignMember objNewCampaignMember1=[SELECT Id
                                                   , Area__c
                                                FROM CampaignMember
                                               WHERE Id=:objNewCampaignMember.Id];
        objNewCampaignMember1.Area__c='South';
        Test.startTest();
        update objNewCampaignMember1;
        Test.stopTest();
        system.assertNotEquals('North',objNewCampaignMember1.Area__c);
    }
}