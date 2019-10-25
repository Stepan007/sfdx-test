/**
 * @author Stepan Ruzicka
 * @date 06.06.2017
 *
 * @description Abstract method which must be implemented in order to enable logging and reprocessing of webservices
 */

public with sharing abstract class WebServiceAbstractClass {
    /*
     * Unfortunatelly parametrised interfaces were removed in Winter '13 so a big
     * part of webservice implementation must be copy-pasted (it can't be implemented dynamically)
     *
     * because of the above reason those properties and methods doesn't make sense to implement:
     *
     * public System.Type connectionClass;
     * public System.Type apiClass;
     * public String apiMethod;
     *
     * public abstract void setConnectionClass();
     * public abstract void setApiClass();
     * public abstract void setApiMethod();
     */

    /**
     * Returns name of current class name
     */
    public String webServiceName =  String.valueOf(this).substring(0, String.valueOf(this).indexOf(':'));

    /**
     * Returns name of current class name
     */
    public String externalWebserviceName =  String.valueOf(this).substring(0, String.valueOf(this).indexOf(':')).removeEnd('WS');

    /**
     * Class where the webservice is currently called out.
     */
    public String userClassName =  IntegrationFrameworkUtils.DEFAULT_USER_CLASS_NAME;

    /**
     * Method name where the webservice is currently called out.
     */
    public String userMethodName = IntegrationFrameworkUtils.DEFAULT_USER_METHOD_NAME;

    /**
     * Globally unique value which is incremented everytime a webservice called out.
     * It is inceremented both for successful and unsuccessful calls.
     */
    public Integer correlationId;

    /**
     * In case a call is reprocessed then the new call is attached to the original one.
     */
    public String originalLogId = LogServicesCommon.DEFAULT_ORIGINAL_LOG_ID;

    /**
     * @description Method which creates a connection (basically endpoint to be called) based on the input data.
     * @param Input data. It could be whatever - map of strings, an instance of a class etc. Based on that connection is created.
	 * @return connection
     */
    public abstract Object createConnection(Object input);

    /**
     * @description Method which carries out a webservice call
     * @param Input data. It could be whatever - map of strings, an instance of a class etc. Based on that connection is created.
	 * @return connection (basically endpoint to be called)
     */
    public abstract Object createRequest(Object input);

    /**
     * @description Method which carries out a webservice call
     * @param A connection (URL, username, password, certificate etc.) used to call the request
     * @param A request to be called
	 * @return Response
     */
    public abstract Object invoke(Object connection, Object request);

    /**
     * @description The same as above with only difference - the connection and request parameters can be passed as JSON parameters
     * @param Connection used to invoke the method
     * @param Request to be called
	 * @return Response
     */
    public abstract String invoke(String connection, String request);

    /**
     * @description Processes the response returned by invoke method
     * @param Original request
     * @param Response. An instance of a class
	 * @return Transformed response which contains only values what we need.
     */
    public abstract Object processResponse(Object request, Object response);

    /**
     * @description Creates and fills in a map with the following values. It is used to log error or info.
     * 'sfObjectId'
     * 'sfObjectType'
     * 'webserviceName'
     * 'resultCode'
     * 'resultHeader'
     * 'resultMessage'
     * 'externalObjectId'
     * 'externalObjectType'
     * 'externalServiceName'
     */
    public abstract Map<String, String> getLogValues(Object request, Object response);


    public WebServiceAbstractClass(){
        setCorrelationId();
    }

    /**
     * @description Constructor where the user class name and user method name is set (for logging purposes)
     * @param User class name
     * @param User method name
     */
    public WebServiceAbstractClass(String userClassNameStr, String userMethodNameStr){
        setCorrelationId();
        userClassName = userClassNameStr;
        userMethodName = userMethodNameStr;
    }

    /**
     * @description User class name setter
     * @param User class name
     */
    public void setUserClassName(String userClassNameStr){
        userClassName = userClassNameStr;
    }

    /**
     * @description User method name setter
     * @param User class name
     */
    public void setUserMethodName(String userMethodNameStr){
        userMethodName = userMethodNameStr;
    }

    /**
     * @description User method name setter
     * @param User class name
     */
    public void setExtWebserviceName(String userMethodNameStr){
        externalWebserviceName = userMethodNameStr;
    }

    /**
     * @description Method used to log an exception
     * @param Request
     * @param Response if any otherwise null
     * @param An exception
     * @return Instance of Log__c sObject
     */
    public Log__c logError(Exception exp, Object connection, Object request, Object response){
        return logError(exp, connection, request, response, userClassName, userMethodName, originalLogId);
    }

    public Log__c logError(String message, Object connection, Object request, Object response){
        return logError(message, connection, request, response, userClassName, userMethodName, originalLogId);
    }

    /**
     * @description Method creates and inserts (if set) a log record
     * @param Request
     * @param Response if any otherwise null
     * @param An exception
     * @param Name of the class where the webservice is called out (the property is usually set up in constructor or explicitly, e.g. when calling the webservice dynamically, using setUserClassName())
     * @param Name of the method where the webservice is called out (the property is usually set up in constructor or explicitly, e.g. when calling the webservice dynamically, using setUserClassName())
     * @param Additional parameter when reprocessing - because of history tracking
     * @return Log record
     */
    public Log__c logError(Exception exp, Object connection, Object request, Object response, String userClassNameStr, String userMethodNameStr, String origLogId){
        Log__c log;

        // initialization
        String sfObjectId = '';
        String sfObjectType = '';
        String resultCode = '';
        String resultHeader = '';
        String resultMessage = '';
        String originalConnection = '';
        String originalRequest = '';
        String externalObjectId = '';
        String externalObjectType = '';
        String externalServiceName = '';

        Map<String, String> logValues = getLogValues(request, response);

        if(logValues != null){
            if(logValues.containsKey('sfObjectId')) sfObjectId = logValues.get('sfObjectId');
            if(logValues.containsKey('sfObjectType')) sfObjectType = logValues.get('sfObjectType');
            if(logValues.containsKey('resultCode')) resultCode = logValues.get('resultCode');
            if(logValues.containsKey('externalObjectId')) originalRequest = logValues.get('externalObjectId');
            if(logValues.containsKey('externalObjectType')) originalRequest = logValues.get('externalObjectType');
            if(logValues.containsKey('externalServiceName')) externalServiceName = logValues.get('externalServiceName');
        }

        if(connection != null){
            originalConnection = JSON.serialize(connection);
        }

        if(request != null){
            originalRequest = JSON.serialize(request);
        }

        log = LogIntegrationServices.logOutboundReprocessException(exp, userClassName, userMethodName, sfObjectId, sfObjectType, webServiceName, resultCode, resultHeader, originalConnection, originalRequest, correlationId, originalLogId, externalObjectId, externalObjectType, externalWebserviceName);

        return log;
    }

    public Log__c logError(String message, Object connection, Object request, Object response, String userClassNameStr, String userMethodNameStr, String origLogId){
        Log__c log;

        // initialization
        String sfObjectId = '';
        String sfObjectType = '';
        String resultCode = '';
        String resultHeader = '';
        String resultMessage = '';
        String originalConnection = '';
        String originalRequest = '';
        String externalObjectId = '';
        String externalObjectType = '';
        String externalServiceName = '';

        Map<String, String> logValues = getLogValues(request, response);

        if(logValues != null){
            if(logValues.containsKey('sfObjectId')) sfObjectId = logValues.get('sfObjectId');
            if(logValues.containsKey('sfObjectType')) sfObjectType = logValues.get('sfObjectType');
            if(logValues.containsKey('resultCode')) resultCode = logValues.get('resultCode');
            if(logValues.containsKey('externalObjectId')) originalRequest = logValues.get('externalObjectId');
            if(logValues.containsKey('externalObjectType')) originalRequest = logValues.get('externalObjectType');
            if(logValues.containsKey('externalServiceName')) externalServiceName = logValues.get('externalServiceName');
        }

        if(connection != null){
            originalConnection = JSON.serialize(connection);
        }

        if(request != null){
            originalRequest = JSON.serialize(request);
        }

        log = LogIntegrationServices.logOutboundReprocessError(message, userClassName, userMethodName, sfObjectId, sfObjectType, webServiceName, resultCode, resultHeader, originalConnection, originalRequest, correlationId, originalLogId, externalObjectId, externalObjectType, externalWebserviceName);

        return log;
    }

    public Log__c logInfo(Object connection, Object request, Object response){
        return logInfo(connection, request, response, originalLogId);
    }

    /**
     * @description Method creates and inserts (if set) a log record
     * @param Request
     * @param Response if any otherwise null
     * @param Additional parameter when reprocessing - because of history tracking
     * @return Log record
     */
    public Log__c logInfo(Object connection, Object request, Object response, String origLogId){
        // initialization
        String sfObjectId = '';
        String sfObjectType = '';
        String resultCode = '';
        String resultHeader = '';
        String originalConnection = '';
        String originalRequest = '';
        String responseJson = '';
        String externalObjectId = '';
        String externalObjectType = '';
        String externalServiceName = '';
        Log__c log;

        Map<String, String> logValues = getLogValues(request, response);

        if(logValues != null){
            if(logValues.containsKey('sfObjectId')) sfObjectId = logValues.get('sfObjectId');
            if(logValues.containsKey('sfObjectType')) sfObjectType = logValues.get('sfObjectType');
            if(logValues.containsKey('resultCode')) resultCode = logValues.get('resultCode');
            if(logValues.containsKey('externalObjectId')) externalObjectId = logValues.get('externalObjectId');
            if(logValues.containsKey('externalObjectType')) externalObjectType = logValues.get('externalObjectType');
            if(logValues.containsKey('externalServiceName')) externalServiceName = logValues.get('externalServiceName');
        }

        if(connection != null){
            originalConnection = JSON.serialize(connection);
        }

        if(request != null){
            originalRequest = JSON.serialize(request);
        }

        if(response != null){
            responseJson = JSON.serialize(response);
        }

        log = LogIntegrationServices.logOutboundReprocessInfo(responseJSON, userClassName, userMethodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, correlationId, originalLogId, externalObjectId, externalObjectType, externalWebserviceName);

        return log;
    }

    /**
     * @description Method which carries out a webservice call
     * @param A connection (URL, username, password, certificate etc.) used to call the request
     * @param A request to be called
     * @param Additional parameter when reprocessing - because of history tracking
	 * @return Response
     */
    public Object invoke(Object connection, Object request, String origLogId){
        originalLogId = origLogId;
        return invoke(connection, request);
    }

    /**
     * @description Method which carries out a webservice call
     * @param A connection (URL, username, password, certificate etc.) used to call the request
     * @param A request to be called
     * @param Additional parameter when reprocessing - because of history tracking
	 * @return Response
     */
    public String invoke(String connection, String request, String origLogId){
        originalLogId = origLogId;
        return invoke(connection, request);
    }

    /**
     * @description Increments and returns correlation ID - globally unique counter of webservice calls
     */
    public void setCorrelationId(){
        correlationId = IntegrationFrameworkUtils.increaseAndGetCorrelationId();
    }
}