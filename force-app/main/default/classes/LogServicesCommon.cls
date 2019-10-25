/**
 * @author: Stepan Ruzicka
 * @date: 05/06/2017
 * @descriptin: Class implements common methods with respect to logging
 * @name LogServicesCommon.cls
 */

public with sharing class LogServicesCommon{

    // constants used by logging framework
    public static final String STANDARD_LOG_TYPE = 'Standard';
    public static final String INTEGRATION_LOG_TYPE = 'Integration';

    public static final String EXCEPTION_MESSAGE = 'The logging failed. Here\'s the exception thrown ';
    public static final String RESULT_MESSAGE_LOGGING_FAILED = 'The logging failed. Here\'s the result message the method was attempting to log: ';
    public static final String LOG_MESSAGE = 'The generated log: ';
    public static final string ERRMSG_EMPTY_MODEL = 'The supplied object is empty.';
    public static final String LOGGING_NOT_ENABLED = 'Logging for this class/method not enabled';
    public static final String GENERATED_LOG = 'The generated log: ';
    public static final String SAVE_RESULT_LOGGING = 'Error(s) Encountered. Please refer to the Log Details field for additional info.';
    public static final String SUCCESS_RESULT_STATUS = 'Successful';
    public static final String ERROR_RESULT_STATUS = 'Unsuccessful';

    // logging - default values
    public static final String DEFAULT_LOG_TYPE = STANDARD_LOG_TYPE;
    public static final Boolean DEFAULT_PERSIST_LOG = true;
    public static final Boolean DEFAULT_SUCCESS_LOG = false;
    public static final Id DEFAULT_ORIGINAL_LOG_ID = null;

    /**
	 * @description This collection stores all generated Log__c entries.
	 */
    public static List<Log__c> generatedLogs = new List<Log__c>();

	/**
     * @description Persists any generated Log__c records, which have not previously been
	 * persisted.
     */
    public static void persistLogs(){
        try{
            upsert generatedLogs;
        }
        catch(exception e){
            //nothing really to do here...where would we log the logging failure?
            System.debug(EXCEPTION_MESSAGE + e);
        }
    }

    /**
     * @description Method checks whether logging for a given setting is on
     * @param Name of a class
     * @param Name of a method
     * @param Flag determining whether the log we want to log is an error or a success log
     * @return True if logging for the given setting is on otherwise False
     */
    public static Boolean loggingIsOn(String className, String methodName, Boolean successLog){
        Boolean ret = false;
        String queryString = '';

        if(methodName != null && methodName != ''){
            queryString = 'SELECT Debug_All__c, Default_Log_Success__c, (select Id, Log_Success__c from Methods__r where Method_Name__c = \'' + methodName + '\' and Active__c = true) FROM Class_Log_Setting__mdt where Active__c = true and Class_Name__c = \'' + className + '\'';
            List<Class_Log_Setting__mdt> classLogSettingList = Database.query(queryString);

            if(classLogSettingList != null && !classLogSettingList.isEmpty()){
                List<Method_Log_Setting__mdt> methodLogSettingList = classLogSettingList.get(0).Methods__r;
                if(methodLogSettingList != null && !methodLogSettingList.isEmpty()){
                    // log success log only if set logging of success logs
                    if(successLog && !methodLogSettingList.get(0).Log_Success__c){
                        ret = false;
                    }else{
                        ret = true;
                    }
                }else{
                    Class_Log_Setting__mdt classLogSetting = classLogSettingList.get(0);
                    if(classLogSetting.Debug_All__c){
                        if(successLog && !classLogSetting.Default_Log_Success__c){
                            ret = false;
                        }else{
                            ret = true;
                        }
                    }
                }
            }
        }else if(className != null && className != ''){
            queryString = 'SELECT Class_Name__c, Debug_All__c FROM Class_Log_Setting__mdt where Active__c = true and Debug_All__c = true and Class_Name__c = \'' + className + '\'';
            if(successLog){
                queryString = queryString + ' and Default_Log_Success__c = true';
            }
            List<Class_Log_Setting__mdt> classLogSettingList = Database.query(queryString);
            if(classLogSettingList != null && !classLogSettingList.isEmpty()) {
                ret = true;
            }
        }

        return ret;
    }

    /**
     * @description Method checks whether logging for a given setting is on. Don't log success log by default.
     * @param Name of a class
     * @param Name of a method
     * @return True if logging for the given setting is on otherwise False
     */
    public static Boolean loggingIsOn(String className, String methodName){
        return loggingIsOn(className, methodName, DEFAULT_SUCCESS_LOG);
    }

    /**
     * @description Method checks whether logging for a given setting is on. Method name is not available.
     * @param Name of a class
     * @param Flag determining whether the log we want to log is an error or a success log
     * @return True if logging for the given setting is on otherwise False
     */
    public static Boolean loggingIsOn(String className, Boolean successLog){
        return loggingIsOn(className, null, successLog);
    }

    /**
     * @description Method checks whether logging for a given setting is on. Method name is not available.  Don't log success log by default.
     * @param Name of a class
     * @return True if logging for the given setting is on otherwise False
     */
    public static Boolean loggingIsOn(String className){
        return loggingIsOn(className, null, DEFAULT_SUCCESS_LOG);
    }

    /**
     * @description Returns record type ID for given record type name
     * @param Record type Name
     * @return Record type ID
     */
    public static Id getLogRecordType(String recordTypeName){
        return getRecordType('Log__c', recordTypeName);
    }

    /**
     * @description Returns record type ID for given sObject type and record type name
     * @param sObject type
     * @param Record type Name
     * @return Record type ID
     */
    public static Id getRecordType(String sObjectType, String recordTypeName){

        List<RecordType> recordTypeList;
        if(sObjectType != null && recordTypeName != null){
            recordTypeList = [select Id FROM RecordType where SobjectType = :sObjectType and Name = :recordTypeName];
        }
        if(recordTypeList != null && recordTypeList.size() > 0){
            return recordTypeList.get(0).Id;
        }else{
            return null;
        }
    }

    //Private Methods
	/*******************************************************************************************************
    * @description Using the supplied Exception record and class name, a Log__c record is initialized
    * @param exp the exception describing the error encountered, which the Log__c record will document
    * @param className the name of the class where the logging action was triggered; presumably the name of the class where the error occurred
    * @return the generated Log__c record
    */
    public static Log__c buildBaseLogFromException(Exception exp, String className, String methodName, Boolean successLog, String logType){
        Log__c	log;

        //build the log
        log = buildBaseLog(exp.getMessage(), className, methodName, successLog, logType);
        if(log != null){
            log.Exception_Type_Name__c = exp.getTypeName();
            log.Stack_Trace__c = exp.getStackTraceString();
            //if the exception is a DML Exception, there are additional fields to process
            if (exp instanceOf DmlException)
                LogServicesCommon.logDMLError((DmlException) exp, log);
        }
        return log;
    }

    public static Log__c buildBaseLogFromException(Exception exp, String className, String methodName) {
        return buildBaseLogFromException(exp, className, methodName, DEFAULT_SUCCESS_LOG, DEFAULT_LOG_TYPE);
    }

    public static Log__c buildBaseLogFromException(Exception exp, String className) {
        return buildBaseLogFromException(exp, className, null, DEFAULT_SUCCESS_LOG, DEFAULT_LOG_TYPE);
    }

    /*******************************************************************************************************
    * @description Using the supplied message and class name, a Log__c record is initialized
    * @param message the message, presumably describing/identifying the error being logged, to use in the generated Log__c record
    * @param className the name of the class where the logging action was triggered; presumably the name of the class where the error occurred
    * @return the generated Log__c record
    */
    public static Log__c buildBaseLog(String message, String className, String methodName, Boolean successLog, String logType){
        Log__c 				log;

        // defaultLogType != null => custom setting for given class exists otherwise don't log!
        if(LogServicesCommon.loggingIsOn(className, methodName, successLog)){
            //build the log
            log 							= new Log__c();
            log.Class_Name__c 				= className;
            if(methodName != null){
                log.Method_Name__c          = methodName;
            }else{
                log.Method_Name__c          = '';
            }
            log.Log_Details__c 				= '';
            log.User__c 					= UserInfo.getUserId();
            log.Result_Message__c 			= message;
            log.Type__c 					= logType;
            log.RecordTypeId			    = getLogRecordType(logType);
            if(successLog){
                log.Result_Status__c        = SUCCESS_RESULT_STATUS;
            }else{
                log.Result_Status__c        = ERROR_RESULT_STATUS;
            }

            System.debug('log **'+ log);
        }else{
            String outputMessage = LOGGING_NOT_ENABLED;
            outputMessage = outputMessage + ' (' + className;
            if(methodName != null){
                outputMessage = outputMessage + '/' + methodName + ')';
            }else{
                outputMessage = outputMessage + ')';
            }
            System.debug(outputMessage);
        }
        return log;
    }

    public static Log__c buildBaseLog(String message, String className){
        return buildBaseLog(message, className, null, DEFAULT_SUCCESS_LOG, DEFAULT_LOG_TYPE);
    }

    public static Log__c buildBaseLog(String message, String className, String methodName){
        return buildBaseLog(message, className, methodName, DEFAULT_SUCCESS_LOG, DEFAULT_LOG_TYPE);
    }

    @TestVisible
	/*******************************************************************************************************
    * @description Using the supplied DMLException record, the supplied Log__r.Log_Details__c field is populated with DML specific failure details
    * @param dExp the DMLException to use to populate the Log__r.Log_Details__c field
    * @param log the Log__c record to populate
    */
    public static void logDMLError(DmlException dExp, Log__c log){
        //iterate over each failed line, documenting their individual errors
        for(integer i = 0; i < dExp.getNumDml(); i++){
            if(log.Log_Details__c == null){
                log.Log_Details__c = '';
            }
            log.Log_Details__c += 'Error Message: ' + dExp.getDMLMessage(i) + '\n';
            log.Log_Details__c += 'DML Failure Type: ' + dExp.getDMLType(i) + '\n';

            //only grab the offending ID if present
            if(!string.isBlank(dExp.getDMLID(i)))
                log.Log_Details__c += 'The following ID caused the error :' + dExp.getDMLID(i) + '.\n';

            //only grab the offending fields if present
            if(dExp.getDMLFieldNames(i).size() > 0)
                //log.Log_Details__c += 'The following fields caused the error: ' + al.stringUtils.joinArray(dExp.getDMLFieldNames(i), ',') + '\n';
                log.Log_Details__c += 'The following fields caused the error: ' + dExp.getDMLFieldNames(i) + '\n';
            //append a newline to separate the messaging logically
            log.Log_Details__c += '\n\n';
        }

        //trim any whitespace
        log.Log_Details__c.trim();

        return;
    }

    @TestVisible
	/*******************************************************************************************************
    * @description Using the supplied Database.SaveResult record, the supplied Log__r.Log_Details__c field is populated with specific failure details
    * @param sr the Database.SaveResult record to use to populate the Log__r.Log_Details__c field
    * @param log the Log__c record to populate
    */
    public static void logSaveResultError(Database.SaveResult sr, Log__c log){
        if(log.Log_Details__c == null){
            log.Log_Details__c = '';
        }
        log.Log_Details__c += 'The following error(s) ocurred';
        log.Log_Details__c += string.isBlank(sr.getID()) ? ':' : ' with record ID ' + sr.getID() + ':';
        log.Log_Details__c += '\n';
        for(Database.Error err : sr.getErrors()){
            //set the base ID
            log.Log_Details__c += err.getMessage() + '.\n';

            //only grab the offending fields if present
            if(err.getFields().size() > 0)
                log.Log_Details__c += 'The following field(s) caused the error: ' + joinArray(err.getFields(), ',') + '\n';
        }

        //append a newline to separate the messaging logically
        log.Log_Details__c += '\n\n';

        return;
    }

    @TestVisible
	/*******************************************************************************************************
    * @description Using the supplied array of Object records and the supplied separator value, a delimited string is generated
    * @param objectArray the array of Object records to concatenate
    * @param separator the string to use to delimit the generated string
    */
    private static String joinArray(Object[] objectArray, String separator){
        Boolean isFirst = true;
        String 	buf = '';

        if (objectArray != null && objectArray.size() > 0 && !string.isBlank(separator)){
            for (Integer i = 0; i < objectArray.size(); i++){
                if(objectArray[i] != null){
                    if(isFirst)
                        isFirst = false;
                    else
                            buf += separator;

                    buf += objectArray[i];
                }
            }
        }
        return buf;
    }
}