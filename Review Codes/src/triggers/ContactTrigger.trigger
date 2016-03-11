trigger ContactTrigger on Contact (before insert) {
    List<Contact> ContactRecords= new List<Contact>(Trigger.New);
    if(Trigger.isInsert && Trigger.isBefore)
    {
        ContactTriggerHandler InitiateHandler=new ContactTriggerHandler();
        InitiateHandler.AssociateContactToAccount(ContactRecords);
    }
}