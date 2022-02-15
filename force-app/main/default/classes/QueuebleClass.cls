public with sharing class QueuebleClass implements Queueable{
    private Map<Id,Account> newMap;
    private Map<Id,Account> oldMap;

    public QueuebleClass() { }

    public QueuebleClass(Map<Id,Account> newMap, Map<Id,Account> oldMap) { 
        this.newMap = newMap;
        this.oldMap = oldMap;
    }

    public void execute(QueueableContext qb) {
        System.debug('runQueuble -- Queuble');
        for(Id accountId : newMap.keySet()){
            if(AccountHelper.AddressEqual(newMap.get(accountId), oldMap.get(accountId))){
                newMap.remove(accountId);
            }
        }

        List<Contact> contactToUpdate = [
                                        SELECT Name, Is_Synced__c, Processed_By_Queue__c 
                                        FROM Contact 
                                        WHERE AccountId IN :newMap.keySet()];
        for(Contact contact : contactToUpdate) {
            contact.Is_Synced__c = false;
            contact.Processed_By_Queue__c = true;
        }  

        update contactToUpdate;
    }
}
