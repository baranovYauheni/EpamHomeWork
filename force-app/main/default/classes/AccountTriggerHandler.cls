public with sharing class AccountTriggerHandler {
    public AccountTriggerHandler() { }

    public static void handleAfterInsert(List<Account> newList, Map<Id,Account> newMap){
        AccountHelper.createTasks(newList);
    }

    public static void handleAfterUpdate(List<Account> newList, 
                                        Map<Id,Account> newMap, List<Account> oldList, 
                                        Map<Id,Account> oldMap){

        AccountHelper.updateAccountContacts(newList, oldList);
        AccountHelper.runQueuble(newMap, oldMap);
    }

    public static void handleAfterDelete(List<Account> oldList, Map<Id,Account> oldMap){
        
    }

    public static void handleAfterUndelete(List<Account> oldList, Map<Id,Account> oldMap){
        
    }

    public static void handleBeforeInsert(List<Account> newList){

    }

    public static void handleBeforeUpdate(List<Account> newList, 
                                            Map<Id,Account> newMap, List<Account> oldList,
                                            Map<Id,Account> oldMap){

    }

    public static void handleBeforeDelete(List<Account> oldList, Map<Id,Account> oldMap){
        
    }
}
