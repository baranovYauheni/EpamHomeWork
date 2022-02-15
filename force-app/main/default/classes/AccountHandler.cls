public with sharing class AccountHandler {
    @InvocableMethod()
    public static void handleAccountPB(List<Id> accountIds) {
        // SOQL request here we create Accounts List
        List<Account> accounts = [
                                    SELECT Name, LastModifiedDate, CreatedDate, 
                                        (
                                            SELECT Subject 
                                            FROM Tasks
                                        ) 
                                    FROM Account 
                                    WHERE Id IN :accountIds
                                ];
        User randomUser = getRandomUser();

        // Check how many Tasks do Account have
        for(Account account: accounts) {
            if (accounts.size() > 0) {
            // Account account = accounts[0];            
                if(account.CreatedDate == account.LastModifiedDate) {
                    insert new Task(
                        Subject = 'Negotioations with ' + account.Name,
                        WhatId  = account.Id
                    );
            } else {
                if(account.Tasks.size() > 3) {
                    for(Task task: account.Tasks) {
                        task.OwnerId = randomUser.Id;
                    }
                    update account.Tasks;
                }
            }               
        }
    }
}
    // SOQL method for searching random user

    public static User getRandomUser() {
        List<User> user = [
                            SELECT Id 
                            FROM User 
                            WHERE IsActive = TRUE
                            ];
        Integer num = (Integer)Math.floor(Math.random() * user.size());
        return user[num];
    }
}
