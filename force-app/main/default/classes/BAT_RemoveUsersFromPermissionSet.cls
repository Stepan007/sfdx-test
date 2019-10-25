/**
* @author Stepan Ruzicka
* @date 08/012/2019
*
* @group GFK
*
* @description  BAT_RemoveUsersFromPermissionSet class : purpose of this class is to remove users from permission set after sandbox refresh.
*/
public class BAT_RemoveUsersFromPermissionSet implements Database.Batchable<sObject>{
    private String permissionSetName;
    private String permissionSetId;
    private Set<String> setOfUsernamesToBeRemoved;
    private Set<Id> setOfUserIdsToBeRemoved;
    
    /**
     * @description       Call the batch with constructor e.g. Database.executeBatch(new BAT_RemoveUsersFromPermissionSet('GfKSingleSignOn', new Set<String>()), 200);
     * @param             Set of usernames which should stay active
     */
    public BAT_RemoveUsersFromPermissionSet(String permissionSetName, Set<String> setOfUsernamesToBeRemoved){
        this.permissionSetName = permissionSetName;
        this.setOfUsernamesToBeRemoved = setOfUsernamesToBeRemoved;
        this.permissionSetId = [SELECT Id FROM PermissionSet WHERE Name =: permissionSetName LIMIT 1].Id;
        List<User> userList = [SELECT Id FROM User where Username in: setOfUsernamesToBeRemoved];
        this.setOfUserIdsToBeRemoved = (new Map<Id,SObject>(userList)).keySet();
    }

    public Database.QueryLocator start(Database.BatchableContext BC){
        if(this.permissionSetName == null){
            return Database.getQueryLocator('');
        }else{
            String permissionSetId = this.permissionSetId;
            Set<Id> setOfUserIdsToBeRemoved = this.setOfUserIdsToBeRemoved;
            String query = 'SELECT Id FROM PermissionSetAssignment WHERE PermissionSetId = : permissionSetId';
            if(!setOfUserIdsToBeRemoved.isEmpty()){
                query = query + ' AND AssigneeId IN : setOfUserIdsToBeRemoved';
            }
            return Database.getQueryLocator(query);
        }
    }
    
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        List<PermissionSetAssignment> permissionSetAssignmentList = (List<PermissionSetAssignment >) scope;
        Database.delete(permissionSetAssignmentList, false);
    }
    
    public void finish(Database.BatchableContext BC){    
    }
}