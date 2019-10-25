/**
 * author: Stepan Ruzicka
 * date: 05/06/2017
 * descriptin: Class implements common constants and methods leveraged by integration framework
 * @name IntegrationFrameworkUtils.cls
 */


public with sharing class IntegrationFrameworkUtils {
    public static final Integer MAX_INTEGER_VALUE = 2147483647;
    public static final String GLOBAL_CORRELATION_SETTING_NAME = 'Global';
    public static final String DEFAULT_USER_CLASS_NAME = 'Not set';
    public static final String DEFAULT_USER_METHOD_NAME = 'Not set';
   
    /**
     * @description Increments and returns correlation ID - globally unique counter of webservice calls
     * @return Value of new correlation ID
     */
    public static Integer increaseAndGetCorrelationId(){
        Integer retValue;
        try{
            retValue = (Singleton.getInstance()).updateAndGetCorrelationId();
        }catch(Exception e){
            LogServices.logError(e, IntegrationFrameworkUtils.class.getName());
        }
        return retValue;
    }
    
/*    
    public static Integer increaseAndGetCorrelationId(){
        Global_Correlation_Id__c correlationId;
        List<Global_Correlation_Id__c> correlationIdList;
        Integer retValue;
        try{
            correlationIdList = [SELECT Id, Value__c FROM Global_Correlation_Id__c limit 1];
            if(!correlationIdList.isEmpty()){
                correlationId = correlationIdList.get(0);
                if(correlationId.Value__c < MAX_INTEGER_VALUE){
                    correlationId.Value__c++;
                }else{
                    correlationId.Value__c = 0;
                }
                // TODO update correlationId; -- throwing uncommitted work pending
            }else{
                correlationId = new Global_Correlation_Id__c(Name = GLOBAL_CORRELATION_SETTING_NAME, Value__c = 1);
                // TODO insert correlationId; -- throwing uncommitted work pending
            }
            retValue = (Integer)correlationId.Value__c;
        }catch(Exception e){
            LogServices.logError(e, IntegrationFrameworkUtils.class.getName());
        }
        return retValue;
    }
*/

    /**
     * @description Increments and returns correlation ID - globally unique counter of webservice calls
     * @return Value of new correlation ID
     */
    public static Integer increaseGetAndUpdateCorrelationId(){
        Global_Correlation_Id__c correlationId;
        List<Global_Correlation_Id__c> correlationIdList;
        Integer retValue;
        try{
            correlationIdList = [SELECT Id, Value__c FROM Global_Correlation_Id__c limit 1];
            if(!correlationIdList.isEmpty()){
                correlationId = correlationIdList.get(0);
                if(correlationId.Value__c < MAX_INTEGER_VALUE){
                    correlationId.Value__c++;
                }else{
                    correlationId.Value__c = 0;
                }
                // TODO update correlationId; -- throwing uncommitted work pending
            }else{
                correlationId = new Global_Correlation_Id__c(Name = GLOBAL_CORRELATION_SETTING_NAME, Value__c = 1);
                // TODO insert correlationId; -- throwing uncommitted work pending
            }
            retValue = (Integer)correlationId.Value__c;
        }catch(Exception e){
            LogServices.logError(e, IntegrationFrameworkUtils.class.getName());
        }
        return retValue;
    }

    /**
     * @description Reprocesses webservice call when "Reprocess" detail/list button is pressed
     * @param Set of IDs to be reprocessed, one value only if detail button is pressed
     * @return Map of results, one value only if detail button is pressed
     */
    public static Map<Id, String> reprocess(Set<String> logIdSet){
        Map<Id, String> responseMap;

        List<Log__c> logList = [select Id, Class_Name__c, Method_Name__c, Webservice_Name__c, Connection__c, Request__c, Reprocessing_Count__c, Salesforce_Object_Id__c from Log__c where Id in :logIdSet];

        if(logList != null && !logList.isEmpty()){
            responseMap = new Map<Id, String>();
            for(Log__c logToBeReprocessed: logList){
                // Get the Type corresponding to the class name
                WebServiceVirtualClass instance;
                String response;

                try{
                    // dynamically create an instance of a given webservice name, unfortunatelly it is not possible to call the constructor
                    // with parameters so we need to set up class name and method name explicitly
                    instance = (WebServiceVirtualClass)System.Type.forName(logToBeReprocessed.Webservice_Name__c).newInstance();
                    // set the original class name where the webservice was called from (logging purposes only)
                    instance.setUserClassName(logToBeReprocessed.Class_Name__c);
                    // set the original method name where the webservice was called from (logging purposes only)
                    instance.setUserMethodName(logToBeReprocessed.Method_Name__c);
                }catch(Exception e){
                    LogIntegrationServices.logOutboundReprocessException(e, logToBeReprocessed.Class_Name__c, logToBeReprocessed.Method_Name__c, '', '', logToBeReprocessed.Webservice_Name__c, '', '', logToBeReprocessed.Connection__c, logToBeReprocessed.Request__c, -1, logToBeReprocessed.Id, '', '', '');
                    return responseMap;
                }
                // call the webservice
                response = instance.invoke(logToBeReprocessed.Connection__c, logToBeReprocessed.Request__c, logToBeReprocessed.Id);

                logToBeReprocessed.Reprocessing_Count__c++;
                responseMap.put(logToBeReprocessed.Id, response);
            }
            update logList;
        }

        return responseMap;
    }
}