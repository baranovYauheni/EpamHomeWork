global class BatchIterableMethods implements Database.Batchable<Contact>, Iterable<Contact>, Iterator<Contact>{
    public integer i;
    List<Contact> contacts;
    public BatchIterableMethods() {
      contacts = [
                    SELECT id, Account.Id, Account.BillingCity, 
                    Account.BillingCountry,
                    Account.BillingLatitude, Account.BillingLongitude, 
                    Account.Updated_By_Contact__c,
                    Account.BillingStreet 
                    FROM Contact 
                    WHERE Is_Synced__c = false
                ];
      i = 0;
    }
    public Iterator<Contact> iterator() {
      return this;
    }
    public boolean hasNext() {
      if(contacts.size() <= i) 
        return false;
      else
        return true;
    }
    public Contact next() {
      i++;
      return contacts[i-1];
    }
    global Iterable<Contact> start(Database.BatchableContext bc) {
      return new BatchIterableMethods();
    } 
    global void execute(Database.BatchableContext bc, List<Contact> scope) {

      List<Account> accList = new List<Account>();
      for(Contact a : scope) {
        a.MailingCity = a.Account.BillingCity;
        a.MailingCountry = a.Account.BillingCountry;
        a.MailingLatitude = a.Account.BillingLatitude;
        a.MailingLongitude = a.Account.BillingLongitude;
        a.MailingStreet = a.Account.BillingStreet;
        a.Is_Synced__c = true;
        System.debug(a.Account.Updated_By_Contact__c);
        a.Account.Updated_By_Contact__c = true;
        accList.add(a.Account);
      }
      update scope;
      //update accList;
    }
    global void finish(Database.BatchableContext bc) {}
}
