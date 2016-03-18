trigger CreateTaskTrigger on Account (after insert) {
    List<Task> TaskList=new List<Task>();
    Task taskAssignment=new Task();
    if(trigger.isInsert && trigger.isAfter)
    {
        for(Account accObj:Trigger.new)
        {
            
            taskAssignment.whatID=accObj.ID;
            taskAssignment.Subject='Meeting with'+accObj.Name;
            taskAssignment.Priority='Normal';
            taskAssignment.Status='Not Started';
            taskAssignment.OwnerId=accObj.OwnerId;
            TaskList.add(taskAssignment);
            system.debug('Task Assigned');
        }
        insert taskAssignment;
    }
}