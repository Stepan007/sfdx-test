/**
 * @author: Stepan Ruzicka
 * @date: 05/06/2017
 * @descriptin: Class implements common methods with respect to logging
 * @name LogIntegrationServices.cls
 */

public with sharing class LogIntegrationServices {
    public enum Direction {
        INBOUND, OUTBOUND
    }

    /**
     * @author Stepan Ruzicka
     * @description - The method creates the log entries in the Integration_Log__c custom object. This method writes the logs into the database.
     * The method tries to put the log entries into one custom object. If it is not possible because of text field size constraints, it will split the log accross objects.
     * In case one entry alone is bigger than 120 000 characters, it is shortened to have 120 003 characters (the shortened text + '...')
     * @param - className
     * @param - methodName
     * @param - sfObjectId
     * @param - sfObjectType
     * @param - webserviceName
     * @param - externalObjectId
     * @param - externalObjectType
     * @param - resultCode
     * @param - resultHeader
     * @param - message
     * @param - direction
     * @param - resultStatus
     * @param - correlationId
     */

    /******************************************** INBOUND *************************************************************/
    /**
     * @description The most simplified version of logInboundError()
     */
    public static Log__c logInboundException(Exception exp, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Integer correlationId, String externalObjectId, String externalObjectType, String externalServiceName){
        return logException(exp, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, Direction.INBOUND, correlationId, LogServicesCommon.DEFAULT_ORIGINAL_LOG_ID, LogServicesCommon.DEFAULT_SUCCESS_LOG, LogServicesCommon.DEFAULT_PERSIST_LOG, externalObjectId, externalObjectType, externalServiceName);
    }

    /**
     * @description We want to link the record with the original log record
     */
    public static Log__c logInboundReprocessException(Exception exp, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Integer correlationId, String originalLogId, String externalObjectId, String externalObjectType, String externalServiceName){
        return logException(exp, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, Direction.INBOUND, correlationId, originalLogId, LogServicesCommon.DEFAULT_SUCCESS_LOG, LogServicesCommon.DEFAULT_PERSIST_LOG, externalObjectId, externalObjectType, externalServiceName);
    }

    /**
     * @description The most simplified version of logInboundError()
     */
    public static Log__c logInboundError(String message, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Integer correlationId, String externalObjectId, String externalObjectType, String externalServiceName){
        return logError(message, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, Direction.INBOUND, correlationId, LogServicesCommon.DEFAULT_ORIGINAL_LOG_ID, LogServicesCommon.DEFAULT_SUCCESS_LOG, LogServicesCommon.DEFAULT_PERSIST_LOG, externalObjectId, externalObjectType, externalServiceName);
    }

    public static Log__c logInboundReprocessError(String message, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Integer correlationId, String originalLogId, String externalObjectId, String externalObjectType, String externalServiceName){
        return logError(message, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, Direction.INBOUND, correlationId, originalLogId, LogServicesCommon.DEFAULT_SUCCESS_LOG, LogServicesCommon.DEFAULT_PERSIST_LOG, externalObjectId, externalObjectType, externalServiceName);
    }

    public static Log__c logInboundInfo(String response, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Integer correlationId, String externalObjectId, String externalObjectType, String externalServiceName){
        return logInfo(response, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, Direction.INBOUND, correlationId, LogServicesCommon.DEFAULT_ORIGINAL_LOG_ID, LogServicesCommon.DEFAULT_PERSIST_LOG, externalObjectId, externalObjectType, externalServiceName);
    }

    public static Log__c logInboundReprocessInfo(String response, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Integer correlationId, String originalLogId, String externalObjectId, String externalObjectType, String externalServiceName){
        return logInfo(response, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, Direction.INBOUND, correlationId, originalLogId, LogServicesCommon.DEFAULT_PERSIST_LOG, externalObjectId, externalObjectType, externalServiceName);
    }

    /******************************************** OUTBOUND ************************************************************/
    public static Log__c logOutboundException(Exception exp, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Integer correlationId, String externalObjectId, String externalObjectType, String externalServiceName){
        return logException(exp, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, Direction.OUTBOUND, correlationId, LogServicesCommon.DEFAULT_ORIGINAL_LOG_ID, LogServicesCommon.DEFAULT_SUCCESS_LOG, LogServicesCommon.DEFAULT_PERSIST_LOG, externalObjectId, externalObjectType, externalServiceName);
    }

    /**
     * @description We want to link the record with the original log record
     */
    public static Log__c logOutboundReprocessException(Exception exp, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Integer correlationId, String originalLogId, String externalObjectId, String externalObjectType, String externalServiceName){
        return logException(exp, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, Direction.OUTBOUND, correlationId, originalLogId, LogServicesCommon.DEFAULT_SUCCESS_LOG, LogServicesCommon.DEFAULT_PERSIST_LOG, externalObjectId, externalObjectType, externalServiceName);
    }

    /**
     * @description The most simplified version of logOutboundError()
     */
    public static Log__c logOutboundError(String message, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Integer correlationId, String externalObjectId, String externalObjectType, String externalServiceName){
        return logError(message, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, Direction.OUTBOUND, correlationId, LogServicesCommon.DEFAULT_ORIGINAL_LOG_ID, LogServicesCommon.DEFAULT_SUCCESS_LOG, LogServicesCommon.DEFAULT_PERSIST_LOG, externalObjectId, externalObjectType, externalServiceName);
    }

    public static Log__c logOutboundReprocessError(String message, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Integer correlationId, String originalLogId, String externalObjectId, String externalObjectType, String externalServiceName){
        return logError(message, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, Direction.OUTBOUND, correlationId, originalLogId, LogServicesCommon.DEFAULT_SUCCESS_LOG, LogServicesCommon.DEFAULT_PERSIST_LOG, externalObjectId, externalObjectType, externalServiceName);
    }

    public static Log__c logOutboundInfo(String response, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Integer correlationId, String externalObjectId, String externalObjectType, String externalServiceName){
        return logInfo(response, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, Direction.OUTBOUND, correlationId, LogServicesCommon.DEFAULT_ORIGINAL_LOG_ID, LogServicesCommon.DEFAULT_PERSIST_LOG, externalObjectId, externalObjectType, externalServiceName);
    }

    public static Log__c logOutboundReprocessInfo(String response, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Integer correlationId, String originalLogId, String externalObjectId, String externalObjectType, String externalServiceName){
        return logInfo(response, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, Direction.OUTBOUND, correlationId, originalLogId, LogServicesCommon.DEFAULT_PERSIST_LOG, externalObjectId, externalObjectType, externalServiceName);
    }



    /**
     * @description Full version of logError()
     */
    public static Log__c logError(String message, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Direction direction, Integer correlationId, String originalId, Boolean successLog, Boolean persistLog, String externalObjectId, String externalObjectType, String externalServiceName){
        Log__c 	log = null;
        try{
            // build the log
            log = buildIntegrationLog(message, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, direction, correlationId, originalId, successLog, externalObjectId, externalObjectType, externalServiceName);

            if(log != null){
                log.Result_Status__c = LogServicesCommon.ERROR_RESULT_STATUS;
                //persist if indicated
                if(persistLog) insert log;

                //add log to the collection
                LogServicesCommon.generatedLogs.add(log);
            }
        }catch(Exception e){
            System.debug(LogServicesCommon.EXCEPTION_MESSAGE + e);
            System.debug(LogServicesCommon.RESULT_MESSAGE_LOGGING_FAILED + message);
            if(log != null) system.debug(LogServicesCommon.LOG_MESSAGE + log);
        }
        return log;
    }

    /**
     * @description Full version of logError()
     */
    public static Log__c logException(Exception exp, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Direction direction, Integer correlationId, String originalId, Boolean successLog, Boolean persistLog, String externalObjectId, String externalObjectType, String externalServiceName){
        Log__c 	log = null;
        try{
            // build the log
            log = buildIntegrationLog(exp, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, direction, correlationId, originalId, successLog, externalObjectId, externalObjectType, externalServiceName);

            if(log != null){
                //persist if indicated
                if(persistLog) insert log;

                //add log to the collection
                LogServicesCommon.generatedLogs.add(log);
            }
        }catch(Exception e){
            System.debug(LogServicesCommon.EXCEPTION_MESSAGE + e);
            if(log != null) system.debug(LogServicesCommon.LOG_MESSAGE + log);
        }
        return log;
    }

    // method with full list of options - by default we set up success log flag because we log an information (no error)
    public static Log__c logInfo(String response, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Direction direction, Integer correlationId, String originalLogId, Boolean persistLog, String externalObjectId, String externalObjectType, String externalServiceName){
        Log__c 	log = null;
        try{
            // build the log - when logging info then success log = true
            log = buildIntegrationLog(response, className, methodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, direction, correlationId, originalLogId, true, externalObjectId, externalObjectType, externalServiceName);

            if(log != null){
                //persist if indicated
                if(persistLog) insert log;

                //add log to the collection
                LogServicesCommon.generatedLogs.add(log);
            }
        }catch(Exception e){
            system.debug(LogServicesCommon.EXCEPTION_MESSAGE + e);
            if(log != null) system.debug(LogServicesCommon.LOG_MESSAGE + log);
        }
        return log;
    }

    public static Log__c buildIntegrationLog(String message, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Direction direction, Integer correlationId, String originalLogId, Boolean successLog, String externalObjectId, String externalObjectType, String externalServiceName){
        Log__c log;

        log = LogServicesCommon.buildBaseLog(message, className, methodName, successLog, LogServicesCommon.INTEGRATION_LOG_TYPE);

        if(log != null){
            log.Webservice_Name__c = webserviceName;
            log.Salesforce_Object_Id__c = sfObjectId;
            log.Salesforce_Object_Type__c = sfObjectType;
            log.Result_Code__c = resultCode;
            log.Result_Header__c = resultHeader;
            log.Direction__c = direction.name().substring(0,1).toUpperCase() + direction.name().substring(1).toLowerCase();
            log.Connection__c = originalConnection;
            log.Request__c = originalRequest;
            log.Type__c = LogServicesCommon.INTEGRATION_LOG_TYPE;
            log.RecordTypeId = LogServicesCommon.getLogRecordType(LogServicesCommon.INTEGRATION_LOG_TYPE);
            log.Correlation_Id__c = correlationId;
            log.User__c = UserInfo.getUserId();
            log.External_Webservice_Name__c = externalServiceName;
            if(originalLogId != null){
                log.Original_Log__c = originalLogId;
            }
        }
        return log;
    }

    public static Log__c buildIntegrationLog(Exception exp, String className, String methodName, String sfObjectId, String sfObjectType, String webserviceName, String resultCode, String resultHeader, String originalConnection, String originalRequest, Direction direction, Integer correlationId, String originalLogId, Boolean successLog, String externalObjectId, String externalObjectType, String externalServiceName){
        Log__c log;

        log = LogServicesCommon.buildBaseLogFromException(exp, className, methodName, successLog, LogServicesCommon.INTEGRATION_LOG_TYPE);

        if(log != null){
            log.Webservice_Name__c = webserviceName;
            log.Salesforce_Object_Id__c = sfObjectId;
            log.Salesforce_Object_Type__c = sfObjectType;
            log.Result_Code__c = resultCode;
            log.Result_Header__c = resultHeader;
            log.Direction__c = direction.name().substring(0,1).toUpperCase() + direction.name().substring(1).toLowerCase();
            log.Connection__c = originalConnection;
            log.Request__c = originalRequest;
            log.Type__c = LogServicesCommon.INTEGRATION_LOG_TYPE;
            log.RecordTypeId = LogServicesCommon.getLogRecordType(LogServicesCommon.INTEGRATION_LOG_TYPE);
            log.Correlation_Id__c = correlationId;
            log.User__c = UserInfo.getUserId();
            log.External_Webservice_Name__c = externalServiceName;
            if(originalLogId != null){
                log.Original_Log__c = originalLogId;
            }
        }
        return log;
    }
}