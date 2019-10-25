@isTest
private class WebServiceAbstractClass_Test{
    static testMethod void test_createConnection_UseCase1(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('TestClass','testMethod');
        webServiceTemplate.createConnection(null);
        System.assertEquals(null, webServiceTemplate.createConnection(null));
    }
    static testMethod void test_createRequest_UseCase1(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('TestClass','testMethod');
        System.assertEquals(null, webServiceTemplate.createRequest(null));
    }
    static testMethod void test_invoke_UseCase1(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('TestClass','testMethod');
        System.assertEquals(null, webServiceTemplate.invoke(webServiceTemplate.createConnection(null), webServiceTemplate.createRequest(null)));
    }
    static testMethod void test_invoke_UseCase2(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('TestClass','testMethod');
        System.assertEquals(null, webServiceTemplate.invoke('', ''));
    }
    static testMethod void test_processResponse_UseCase1(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('TestClass','testMethod');
        System.assertEquals(null, webServiceTemplate.processResponse(webServiceTemplate.createRequest(null), webServiceTemplate.invoke(webServiceTemplate.createConnection(null), webServiceTemplate.createRequest(null))));
    }
    static testMethod void test_getLogValues_UseCase1(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('TestClass','testMethod');
        Map<String, String> valuesMap = webServiceTemplate.getLogValues(webServiceTemplate.createRequest(null), webServiceTemplate.invoke(webServiceTemplate.createConnection(null), webServiceTemplate.createRequest(null)));
        System.assertEquals('', valuesMap.get('sfObjectId'));
    }
    static testMethod void test_setUserClassName_UseCase1(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate();
        webServiceTemplate.setUserClassName('TestClass');
        System.assertEquals('TestClass', webServiceTemplate.userClassName);
    }
    static testMethod void test_setUserMethodName_UseCase1(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate();
        webServiceTemplate.setUserMethodName('testMethod');
        System.assertEquals('testMethod', webServiceTemplate.userMethodName);
    }
    static testMethod void test_logError_UseCase1(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('TestClass','testMethod');
        try{
            insert new Account();
        }catch(Exception exp){
            webServiceTemplate.logError(exp,webServiceTemplate.createConnection(null),webServiceTemplate.createRequest(null),webServiceTemplate.invoke(webServiceTemplate.createConnection(null), webServiceTemplate.createRequest(null)));
        }
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c from Log__c limit 1];
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [Name]: [Name]', log.Result_Message__c);
    }
    static testMethod void test_logError_UseCase2(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('TestClass','testMethod');
        try{
            insert new Account();
        }catch(Exception exp){
            webServiceTemplate.logError(exp,webServiceTemplate.createConnection(null),webServiceTemplate.createRequest(null),webServiceTemplate.invoke(webServiceTemplate.createConnection(null), webServiceTemplate.createRequest(null)),'TestClass','testMethod',null);
        }
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c from Log__c limit 1];
        System.assertEquals('Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [Name]: [Name]', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
    }
    static testMethod void test_logError_UseCase3(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('TestClass','testMethod');
        webServiceTemplate.logError('Something went wrong',webServiceTemplate.createConnection(null),webServiceTemplate.createRequest(null),webServiceTemplate.invoke(webServiceTemplate.createConnection(null), webServiceTemplate.createRequest(null)),'TestClass','testMethod','test data');
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c from Log__c limit 1];
        System.assertEquals('Something went wrong', log.Result_Message__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
    }
    static testMethod void test_logInfo_UseCase1(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('TestClass','testMethod');
        webServiceTemplate.logInfo(webServiceTemplate.createConnection(null), webServiceTemplate.createRequest(null),webServiceTemplate.invoke(webServiceTemplate.createConnection(null), webServiceTemplate.createRequest(null)));
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Correlation_ID__c from Log__c limit 1];
        System.assertEquals(null, log.Result_Message__c);
        System.assertEquals('Successful', log.Result_Status__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertNotEquals(null, log.Correlation_ID__c);
    }
    static testMethod void test_logInfo_UseCase2(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('TestClass','testMethod');
        webServiceTemplate.setCorrelationId();
        webServiceTemplate.logInfo(webServiceTemplate.createRequest(null),webServiceTemplate.invoke(webServiceTemplate.createConnection(null), webServiceTemplate.createRequest(null)),null);
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Correlation_ID__c from Log__c limit 1];
        System.assertEquals(null, log.Result_Message__c);
        System.assertEquals('Successful', log.Result_Status__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals(1, log.Correlation_ID__c);
    }
    static testMethod void test_setCorrelationId_UseCase1(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('TestClass','testMethod');
        webServiceTemplate.setCorrelationId();
        System.assertEquals(1, webServiceTemplate.correlationId);
    }

}