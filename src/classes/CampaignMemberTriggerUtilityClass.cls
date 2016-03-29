//This class creates the data required for CampaignMemberTriggerTestClass
public class CampaignMemberTriggerUtilityClass{
    //This method generates the records for campaign members.
    public static List<CampaignMember> createCampaignMembers(Id TRYCampaignId){
        List<Contact> contactRecord=createContacts();
        List<Lead> leadRecord=createLeads();
        system.debug(contactRecord[0].Id);
        CampaignMember objMember1=new CampaignMember(ContactID=contactRecord[0].Id,Participation_Role__c='Volunteer',CampaignId=TRYCampaignId);
        CampaignMember objMember2=new CampaignMember(ContactID=contactRecord[1].Id,Participation_Role__c='Volunteer',CampaignId=TRYCampaignId);
        CampaignMember objMember3=new CampaignMember(ContactID=contactRecord[2].Id,Participation_Role__c='Volunteer',CampaignId=TRYCampaignId);
        CampaignMember objMember4=new CampaignMember(LeadId=leadRecord[0].Id,Participation_Role__c='Volunteer',CampaignId=TRYCampaignId);
        CampaignMember objMember5=new CampaignMember(LeadId=leadRecord[1].Id,Participation_Role__c='Volunteer',CampaignId=TRYCampaignId);
        List<CampaignMember> campaignRecord=new List<CampaignMember>();
        campaignRecord.add(objMember1);
        campaignRecord.add(objMember2);
        campaignRecord.add(objMember3);
        campaignRecord.add(objMember4);
        campaignRecord.add(objMember5);
        system.debug(campaignRecord);
        return campaignRecord;
    } 
    
    //This method creates the contact records for the campaign members.
    public static List<Contact> createContacts(){
        Contact objContact1=new Contact(FirstName='Ashish',LastName='Agarwal',MailingCity='Pune',Area__c='South',Campaign_Awareness_Type__c='Health Issues',Participation_Role__c='Volunteer');
        Contact objContact2=new Contact(FirstName='Tushar',LastName='Kakade',MailingCity='Nashik',Area__c='South',Campaign_Awareness_Type__c='Blood Donation',Participation_Role__c='Volunteer');
        Contact objContact3=new Contact(FirstName='Bhushan',LastName='Patil',MailingCity='Pune',Area__c='South',Campaign_Awareness_Type__c='Health Issues',Participation_Role__c='Volunteer');
        List<Contact> ListContact=new List<Contact>();
        ListContact.add(objContact1);
        ListContact.add(objContact2);
        ListContact.add(objContact3);
        insert ListContact;
        return ListContact;
    } 
    
    //This method creates the lead records for the campaign members.
    public static List<Lead> createLeads(){
        Lead objLead1=new Lead(FirstName='Varsha',LastName='Gupta',City='Pune',Status='Open',Company='Eternus',Area__c='West',Campaign_Awareness_Type__c='Organ Donation',Participation_Role__c='Volunteer');
        Lead objLead2=new Lead(FirstName='Shunali',LastName='Mehra',City='Bhopal',Status='Open',Company='Eternus',Area__c='East',Campaign_Awareness_Type__c='Under Nourishment',Participation_Role__c='Volunteer');
        List<Lead> ListLead=new List<Lead>();
        ListLead.add(objLead1);
        ListLead.add(objLead2);
        insert ListLead;
        return ListLead;
    }
}