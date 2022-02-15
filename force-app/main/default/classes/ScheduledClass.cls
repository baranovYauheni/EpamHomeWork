public with sharing class ScheduledClass implements Schedulable{
    public ScheduledClass() {}

    public void execute(SchedulableContext ctx){
        system.debug('Batch is started');
        Database.executeBatch(new BatchClass(), 10);
        Database.executeBatch(new BatchIterableMethods());
    }
}
