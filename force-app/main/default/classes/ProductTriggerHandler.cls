public with sharing class ProductTriggerHandler {
    public ProductTriggerHandler() { }

    public static void handleAfterInsert(List<Product2> newList, Map<Id,Product2> newMap){

    }

    public static void handleAfterUpdate(List<Product2> newList, Map<Id,Product2> newMap, List<Product2> oldList, Map<Id,Product2> oldMap){
        
    }

    public static void handleAfterDelete(List<Product2> oldList, Map<Id,Product2> oldMap){
        
    }

    public static void handleAfterUndelete(List<Product2> oldList, Map<Id,Product2> oldMap){
        
    }

    public static void handleBeforeInsert(List<Product2> newList){

    }

    public static void handleBeforeUpdate(List<Product2> newList, Map<Id,Product2> newMap, List<Product2> oldList, Map<Id,Product2> oldMap){
        ProductHelper.SingleRun(newList);
    }

    public static void handleBeforeDelete(List<Product2> oldList, Map<Id,Product2> oldMap){
        
    }

}
