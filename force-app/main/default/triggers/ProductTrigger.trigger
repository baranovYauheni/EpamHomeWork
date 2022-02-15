trigger ProductTrigger on Product2 (before insert, 
                                    before update, 
                                    before delete, 
                                    after insert, 
                                    after update, 
                                    after delete, 
                                    after undelete) {

    if(Trigger.isBefore && Trigger.isInsert){
        ProductTriggerHandler.handleBeforeInsert(Trigger.new);
    }

    if(Trigger.isBefore && Trigger.isUpdate){
        ProductTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
    }

    if(Trigger.isBefore && Trigger.isDelete){
        ProductTriggerHandler.handleBeforeDelete(Trigger.old, Trigger.oldMap);
    }

    if(Trigger.isAfter && Trigger.isInsert){
        ProductTriggerHandler.handleAfterInsert(Trigger.new, Trigger.newMap);
    }

    if(Trigger.isAfter && Trigger.isUpdate){
        ProductTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
    }

    if(Trigger.isAfter && Trigger.isDelete){
        ProductTriggerHandler.handleAfterDelete(Trigger.old, Trigger.oldMap);
    }

    if(Trigger.isAfter && Trigger.isUndelete){
        ProductTriggerHandler.handleAfterUndelete(Trigger.old, Trigger.oldMap);
    }
}