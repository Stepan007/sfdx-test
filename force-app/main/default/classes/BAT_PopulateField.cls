/**
* @author Stepan Ruzicka
* @date 08/012/2019
*
* @group GFK
*
* @description  BAT_PopulateField class : purpose of this class is to remove users from permission set after sandbox refresh.
*/
public class BAT_PopulateField implements Database.Batchable<sObject>{
    private Map<String, Schema.SObjectType> schemaMap;
    private Map<String, Schema.SObjectField> fieldMap;
    private String sObjectName;
    private String sourceField;
    private String destinationField;
    private String sourceFieldLower;
    private String destinationFieldLower;
    private Boolean overrideMode;
    
    public BAT_PopulateField(String sObjectName, String sourceField, String destinationField){
       initialize(sObjectName, sourceField, destinationField, false);
    }
    public BAT_PopulateField(String sObjectName, String sourceField, String destinationField, Boolean overrideMode){
       initialize(sObjectName, sourceField, destinationField, overrideMode);
    }
    
    private void initialize(String sObjectName, String sourceField, String destinationField, Boolean overrideMode){
        this.schemaMap = Schema.getGlobalDescribe();
        if(schemaMap.containsKey(sObjectName)){
           this.fieldMap = schemaMap.get(sObjectName).getDescribe().fields.getMap();
        }else{
            throw new ObjectMissingDefinitionException('sObject with name ' + this.sObjectName + ' not defined');
        }
        this.sObjectName = sObjectName;
        this.sourceField = sourceField;
        this.destinationField = destinationField;
        this.sourceFieldLower = sourceField.toLowerCase();
        this.destinationFieldLower = destinationField.toLowerCase();
        this.overrideMode = overrideMode;
    }

    public Database.QueryLocator start(Database.BatchableContext BC){
        String query;
        if(this.fieldMap.containsKey(sourceFieldLower) && this.fieldMap.containsKey(destinationFieldLower)){
            query = 'SELECT ' + this.sourceField + ', ' + this.destinationField + ' FROM ' + sObjectName;
            if(!this.overrideMode){
                query = query + ' WHERE ' + destinationField + ' = NULL'; 
            }
        }else{
            if(fieldMap.containsKey(sourceFieldLower)){
                throw new ObjectMissingDefinitionException('Field ' + this.destinationFieldLower + ' not defined for object ' + this.sObjectName);
            }else{
                throw new ObjectMissingDefinitionException('Field ' + this.sourceField + ' not defined for object ' + this.sObjectName);
            }
        }
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        List<sObject> sObjList = (List<sObject>) scope;
        for(sObject obj: sObjList){
           obj.put(this.destinationField, (String)obj.get(this.sourceField));
        }
        Database.update(sObjList, false);
    }
    
    public void finish(Database.BatchableContext BC){    
    }
    
    private class ObjectMissingDefinitionException extends Exception {}
}