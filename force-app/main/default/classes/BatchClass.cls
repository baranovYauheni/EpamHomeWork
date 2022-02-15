public with sharing class BatchClass implements Database.Batchable<SObject>, Database.Stateful{
    public BatchClass() {}

    private static Integer countOfIteration = 1; 

    public Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('Start of Batch');
        return Database.getQueryLocator('select id, Account.Owner.Name, Account.Updated_By_Task__c from Task where Is_Synced__c = false');
    }

    public void execute(Database.BatchableContext bc, List<Task> tasks){

        List<Account> accList = new List<Account>();
        System.debug('Iteration: ' + countOfIteration++);
        for(Task task : tasks){
            task.Account_Owner__c = task.Account.Owner.Name;
            task.Is_Synced__c = true;
            task.Account.Updated_By_Task__c = true; 
            accList.add(task.Account);
        }

        update tasks;
        //update accList;
        
    }

    public void finish(Database.BatchableContext bc){
        System.debug('End of Batch');
    }
}
