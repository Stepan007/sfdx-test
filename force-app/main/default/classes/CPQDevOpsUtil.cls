global class CPQDevOpsUtil {
    public class CPQDevOpsUtilException extends Exception {}
    public static void populateField(String sObjectName, String sourceField, String destinationField, Boolean overrideMode){
        Map<String, Schema.SObjectType> schemaMap;
        Map<String, Schema.SObjectField> fieldMap;
        String sourceFieldLower;
        String destinationFieldLower;
        String query;
        
        schemaMap = Schema.getGlobalDescribe();
        if(schemaMap.containsKey(sObjectName)){
           fieldMap = schemaMap.get(sObjectName).getDescribe().fields.getMap();
        }else{
            throw new CPQDevOpsUtilException('sObject with name ' + sObjectName + ' not defined');
        }
        
        sourceFieldLower = sourceField.toLowerCase();
        destinationFieldLower = destinationField.toLowerCase();
        if(fieldMap.containsKey(sourceFieldLower) && fieldMap.containsKey(destinationFieldLower)){
            query = 'select ' + sourceField + ', ' + destinationField + ' from ' + sObjectName;
            List<sObject> sObjList = Database.query(query);
            for(sObject obj: sObjList){
                // update only when the destination field is empty
                if(String.isBlank((String)obj.get(destinationField)) || overrideMode){
                   obj.put(destinationField, (String)obj.get(sourceField));
                }
            }
            Database.update(sObjList, false);
        }else{
            throw new CPQDevOpsUtilException('Field ' + sourceField + ' not defined for object ' + sObjectName);
        }
    }
    
    public static void populateField(String sObjectName, String sourceField, String destinationField){
       CPQDevOpsUtil.populateField(sObjectName, sourceField, destinationField, false);
    }
}