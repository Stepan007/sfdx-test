/**
 * @author Stepan Ruzicka
 * @date 06.06.2017
 *
 * @description virtual method which must be implemented in order to enable logging and reprocessing of webservices
 */

public with sharing virtual class WebServiceVirtualClass {
    private class ConfigurationMissingException extends Exception {}

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
     * public virtual void setConnectionClass();
     * public virtual void setApiClass();
     * public virtual void setApiMethod();
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

    public Object connection;
    public Object request;

    /**
     * In case a call is reprocessed then the new call is attached to the original one.
     */
    public String originalLogId = LogServicesCommon.DEFAULT_ORIGINAL_LOG_ID;

    public Object createConnection(){
        return createConnection(null);
    }

    public virtual Object createConnection(Object input){
        Map<String, String> connectionMap = new Map<String, String>();
        connectionMap.put('Endpoint', (String) input);
        connectionMap.put('Content-Type', 'text/xml');
        connectionMap.put('Method', 'POST');
        connectionMap.put('SoapAction', externalWebserviceName);
        connection = connectionMap;
        return connectionMap;
    }

    public virtual Object createRequest(){
        return createRequest(null);
    }

    public virtual Object createRequest(Object input){
        request = input;
        return input;
    }

    public virtual Object invoke(){
        return invoke(connection, request);
    }

    public virtual Object invoke(Object connectionObj, Object requestObj){
        Map<String, String> connectionMap = (Map<String, String>)connectionObj;
        System.HttpRequest req = new System.HttpRequest();
        HTTPResponse response;
        String processedResponse;

        if(connectionMap != null){
            for(String key: connectionMap.keySet()){
                if(key == 'method') {
                    req.setMethod(connectionMap.get(key));
                }else if(key == 'endpoint'){
                    req.setEndpoint(connectionMap.get(key));
                }else{
                    req.setHeader(key, connectionMap.get(key));
                }
            }
        }

        try{
            req.setBody((String)requestObj);
            response = (new Http()).send(req);
        }catch(Exception exp){
            logError(exp, connectionObj, requestObj, response.toString());
            return null;
        }

        try{
            processedResponse = (String)processResponse(request, response);
        }catch(Exception exp){
            logError(exp, connectionObj, requestObj, response.getBody());
            return null;
        }

        logInfo(connectionObj, requestObj, response.getBody());

        return processedResponse;
    }

    public virtual String invoke(String connectionStr, String requestStr){
        String responseStr;
        Map<String, String> connectionObj = (Map<String, String>)JSON.deserialize(connectionStr, Map<String, String>.class);

        responseStr = JSON.serialize(invoke(connectionObj, requestStr));
        return responseStr;
    }

    public virtual Object processResponse(Object request, Object response){
        HTTPResponse res = (HTTPResponse)response;
        return res.toString();
    }

    /**
     * @description Creates and fills in a map with the following values. It is used to log error or info.
     * 'sfObjectId'
     * 'sfObjectType'
     * 'resultCode'
     * 'resultHeader'
     * 'resultMessage'
     * 'externalObjectId'
     * 'externalObjectType'
     * 'externalServiceName'
     */
    public virtual Map<String, String> getLogValues(Object request, Object response){
        return new Map<String, String>();
    }


    public WebServiceVirtualClass(){
        setCorrelationId();
    }

    /**
     * @description Constructor where the user class name and user method name is set (for logging purposes)
     * @param User class name
     * @param User method name
     */
    public WebServiceVirtualClass(String userClassNameStr, String userMethodNameStr){
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

        log = LogIntegrationServices.logOutboundReprocessInfo(responseJson, userClassName, userMethodName, sfObjectId, sfObjectType, webserviceName, resultCode, resultHeader, originalConnection, originalRequest, correlationId, originalLogId, externalObjectId, externalObjectType, externalWebserviceName);

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
    
    /**
     * @description Returns webservice endpoint URL
     */
    public String getEndpointURL(){
        String endpoint;

        try{
            endpoint = WebServices_CS__c.getInstance(externalWebserviceName).Endpoint_URL__c ;
        }catch(Exception exp){
            throw new ConfigurationMissingException('Method getEndpointURL() - configuration missing for webservice: ' + externalWebserviceName);
        }

        return endpoint;
    }
    
    /**
     * @description Returns webservice username
     */
    public String getUsername(){
        String username;

        try{
            username = WebServices_CS__c.getInstance(externalWebserviceName).Username__c ;
        }catch(Exception exp){
            throw new ConfigurationMissingException('Method getUsername() - configuration missing for webservice: ' + externalWebserviceName);
        }

        return username;
    }
    
    /**
     * @description Returns webservice username
     */
    public String getPassword(){
        String password;

        try{
            password = WebServices_CS__c.getInstance(externalWebserviceName).Password__c ;
        }catch(Exception exp){
            throw new ConfigurationMissingException('Method getPassword() - configuration missing for webservice: ' + externalWebserviceName);
        }

        return password;
    }

    /**
     * @description Returns webservice client ID
     */
    public String getClientID(){
        String clientID;

        try{
            clientID = WebServices_CS__c.getInstance(externalWebserviceName).Client_ID__c ;
        }catch(Exception exp){
            throw new ConfigurationMissingException('Method getClientID() - configuration missing for webservice: ' + externalWebserviceName);
        }

        return clientID;
    }
    
    /**
     * @description Returns webservice client secret
     */
    public String getClientSecret(){
        String clientSecret;

        try{
            clientSecret = WebServices_CS__c.getInstance(externalWebserviceName).Client_Secret__c ;
        }catch(Exception exp){
            throw new ConfigurationMissingException('Method getClientSecret() - configuration missing for webservice: ' + externalWebserviceName);
        }

        return clientSecret;
    }
    
    /**
     * @description Returns webservice timeout
     */
    public Integer getTimeout(){
        Decimal timeout;

        try{
            timeout = WebServices_CS__c.getInstance(externalWebserviceName).Timeout__c ;
        }catch(Exception exp){
            throw new ConfigurationMissingException('Method getTimeout() - configuration missing for webservice: ' + externalWebserviceName);
        }

        return timeout.intValue();
    }
    
    /**
     * @description Returns webservice reprocessing count
     */
    public Integer getReprocessingCount(){
        Decimal reprocessingCount;

        try{
            reprocessingCount = WebServices_CS__c.getInstance(externalWebserviceName).Reprocessing_Count__c ;
        }catch(Exception exp){
            throw new ConfigurationMissingException('Method getReprocessingCount() - configuration missing for webservice: ' + externalWebserviceName);
        }

        return reprocessingCount.intValue();
    }
}