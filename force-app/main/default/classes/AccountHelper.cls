public with sharing class AccountHelper {
    public AccountHelper() { }

    public static Map<Id, String> accountToMap(List<Account> newList){

        Map<Id, String> mp = new Map<Id,String>();
        for(Account acc : newList){
            mp.put(acc.Id, acc.Name);
        }

        return mp;
    }
    
    public static boolean AddressEqual(Account acc1, Account acc2){
        if( acc1.BillingCity != acc2.BillingCity || acc1.BillingCountry != acc2.BillingCountry || 
            acc1.BillingGeocodeAccuracy != acc2.BillingGeocodeAccuracy || acc1.BillingLatitude != acc2.BillingLatitude || 
            acc1.BillingLongitude != acc2.BillingLongitude || acc1.BillingPostalCode != acc2.BillingPostalCode ||
            acc1.BillingState !=  acc2.BillingState || acc1.BillingStreet != acc2.BillingStreet) 
        return false;
        else return true;
    }

    public static void createTasks(List<Account> newList){
        System.debug('CreateTask -- Main');
        Map<Id,String> accMap = accountToMap(newList);
        createFutureTask(accMap);
    }


    @future
    public static void createFutureTask(Map<Id,String> accountMap){
        System.debug('CreateTask -- Future');

        List<Task> newTasks = new List<Task>();

        for(Id accountId : accountMap.keySet()){
            Task task = new Task();
            task.WhatId = accountId;
            task.Subject = 'Negotiations with ' + accountMap.get(accountId);
            task.Is_Synced__c = false;
            newTasks.add(task);
        }

        insert newTasks;  
    }


    public static void updateAccountContacts(List<Account> newList, List<Account> oldList){

        System.debug('updateAccountContacts -- Main');
        List<String> newSerAcc = new List<String>();
        List<String> oldSerAcc = new List<String>();

        for(Account acc : newList) {
            newSerAcc.add(JSON.serialize(acc));
        }
        for(Account acc : oldList) {
            oldSerAcc.add(JSON.serialize(acc));
        }

        updateFutureAccountContacts(newSerAcc, oldSerAcc);


    }

    @future
    public static void updateFutureAccountContacts(List<String> newSerAcc, List<String> oldSerAcc){
        System.debug('updateAccountContacts -- Future');

        Map<Id,Account> oldMap = new Map<Id, Account>();
        Map<Id,Account> newMap = new Map<Id, Account>();

        for(String str : newSerAcc){
            Account account = (Account) JSON.deserialize(str, Account.class);
            newMap.put(account.Id, account);
        }

        for(String str : oldSerAcc){
            Account account = (Account) JSON.deserialize(str, Account.class);
            oldMap.put(account.Id, account);
        }

        for(Id accountId : newMap.keySet()){
            if(AddressEqual(newMap.get(accountId), oldMap.get(accountId))){
                newMap.remove(accountId);
            }
        }

        List<Contact> contactToUpdate = [
                                        SELECT Name, Is_Synced__c, Processed_By_Future__c 
                                        FROM Contact 
                                        WHERE AccountId IN :newMap.keySet()
                                        ];
        for(Contact contact : contactToUpdate) {
            contact.Is_Synced__c = false;
            contact.Processed_By_Future__c = true;
        }  

        update contactToUpdate;
    }

    public static void runQueuble(Map<Id,Account> newMap, Map<Id,Account> oldMap) {
        System.debug('runQueuble -- Mainn');
        System.enqueueJob(new QueuebleClass(newMap, oldMap));
    }
}
