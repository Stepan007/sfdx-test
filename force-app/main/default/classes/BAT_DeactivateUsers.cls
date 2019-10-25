/**
* @author Stepan Ruzicka
* @date 08/012/2019
*
* @group GFK
*
* @description  BAT_DeactivateUsers class : purpose of this class is to deactivate users after sandbox refresh.
*/
public class BAT_DeactivateUsers implements Database.Batchable<sObject>{
    private Set<String> usernameSetToKeepActive;
    /*
    * @description       Call the batch with constructor e.g. BAT_DeactivateUsers(new Set<String>{'stepan.ruzicka@gfk.com.uatmain'});
    * @param             Set of usernames which should stay active
    * */
    public BAT_DeactivateUsers(Set<String> usernameSetToKeepActive){
        this.usernameSetToKeepActive = usernameSetToKeepActive;
    }

    public Database.QueryLocator start(Database.BatchableContext BC){
        // exclude users which should stay active 
        String query = 'SELECT Id, IsActive FROM User';
        Set<String> usernameSetToKeepActive;
        if(this.usernameSetToKeepActive != null){
            usernameSetToKeepActive = this.usernameSetToKeepActive;
            query = query + ' WHERE Username NOT IN: usernameSetToKeepActive';
        }
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        List<User> userList = (List<User>) scope;
        for(User theUser: userList){
            theUser.IsActive = false;
        }
        Database.update(userList, false);
    }
    
    public void finish(Database.BatchableContext BC){    
    }
}