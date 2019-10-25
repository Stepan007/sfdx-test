@isTest
private class LogIntegrationServices_Test{
    static testMethod void test_logInboundException_UseCase1(){
        try{
            insert new Account();
        }catch(Exception exp){
            LogIntegrationServices.logInboundException(exp,'TestClass','testMethod',null,'Account','CreateBillingAccount','','','','',0,null,'Account','CreateBillingAccount');
        }
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c, Webservice_Name__c, Original_Log__c, Direction__c from Log__c limit 1];
        System.assertEquals('Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [Name]: [Name]', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
        System.assertEquals('Error Message: Required fields are missing: [Name]\nDML Failure Type: REQUIRED_FIELD_MISSING\nThe following fields caused the error: (Name)', log.Log_Details__c);
        System.assertEquals('CreateBillingAccount', log.Webservice_Name__c);
        System.assertEquals(null, log.Original_Log__c);
        System.assertEquals('Inbound', log.Direction__c);
    }
    static testMethod void test_logInboundReprocessException_UseCase1(){
        Log__c log;
        try{
            insert new Account();
        }catch(Exception exp) {
            log = LogIntegrationServices.logInboundReprocessException(exp, 'TestClass', 'testMethod', null, 'Account', 'CreateBillingAccount', '', '', '', '', 0, null, 'Account', 'CreateBillingAccount', null);
        }
        List<Log__c> logList = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c, Webservice_Name__c, Original_Log__c, Direction__c from Log__c];
        log = logList.get(0);
        System.assertEquals('Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [Name]: [Name]', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
        System.assertEquals('Error Message: Required fields are missing: [Name]\nDML Failure Type: REQUIRED_FIELD_MISSING\nThe following fields caused the error: (Name)', log.Log_Details__c);
        System.assertEquals('CreateBillingAccount', log.Webservice_Name__c);
        System.assertEquals(null, log.Original_Log__c);
        System.assertEquals('Inbound', log.Direction__c);
    }
    static testMethod void test_logInboundError_UseCase1(){
        LogIntegrationServices.logInboundError('Something went wrong','TestClass','testMethod',null,'Account','CreateBillingAccount','','','','',0,null,'Account','CreateBillingAccount');
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c, Webservice_Name__c, Original_Log__c, Direction__c from Log__c limit 1];
        System.assertEquals('Something went wrong', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
        System.assertEquals(null, log.Log_Details__c);
        System.assertEquals('CreateBillingAccount', log.Webservice_Name__c);
        System.assertEquals(null, log.Original_Log__c);
        System.assertEquals('Inbound', log.Direction__c);
    }
    static testMethod void test_logInboundReprocessError_UseCase1(){
        LogIntegrationServices.logInboundReprocessError('Something went wrong','TestClass','testMethod',null,'Account','CreateBillingAccount','','','','',0,null,'Account','CreateBillingAccount', null);
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c, Webservice_Name__c, Original_Log__c, Direction__c from Log__c limit 1];
        System.assertEquals('Something went wrong', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
        System.assertEquals(null, log.Log_Details__c);
        System.assertEquals('CreateBillingAccount', log.Webservice_Name__c);
        System.assertEquals(null, log.Original_Log__c);
        System.assertEquals('Inbound', log.Direction__c);
    }
    static testMethod void test_logInboundInfo_UseCase1(){
        LogIntegrationServices.logInboundInfo('', 'TestClass','testMethod',null,'Account','CreateBillingAccount','','','','',0,null,'Account','CreateBillingAccount');
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c, Webservice_Name__c, Original_Log__c, Direction__c from Log__c limit 1];
        System.assertEquals(null, log.Result_Message__c);
        System.assertEquals('Inbound', log.Direction__c);
        System.assertEquals('Successful', log.Result_Status__c);
    }
    static testMethod void test_logInboundReprocessInfo_UseCase1(){
        Log__c origLog = new Log__c();
        insert origLog;
        LogIntegrationServices.logInboundReprocessInfo('', 'TestClass','testMethod',null,'Account','CreateBillingAccount','','','','',0,origLog.Id,'Account','CreateBillingAccount', null);
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c, Webservice_Name__c, Original_Log__c, Direction__c from Log__c where Id <> :origLog.Id limit 1];
        System.assertEquals(null, log.Result_Message__c);
        System.assertEquals('Inbound', log.Direction__c);
        System.assertEquals('Successful', log.Result_Status__c);
        System.assertNotEquals(null, log.Original_Log__c);
    }

    /************************** Outbound ***************************/
    static testMethod void test_logOutboundException_UseCase1(){
        try{
            insert new Account();
        }catch(Exception exp){
            LogIntegrationServices.logOutboundException(exp,'TestClass','testMethod',null,'Account','CreateBillingAccount','','','','',0,null,'Account','CreateBillingAccount');
        }
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c, Webservice_Name__c, Original_Log__c, Direction__c from Log__c limit 1];
        System.assertEquals('Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [Name]: [Name]', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
        System.assertEquals('Error Message: Required fields are missing: [Name]\nDML Failure Type: REQUIRED_FIELD_MISSING\nThe following fields caused the error: (Name)', log.Log_Details__c);
        System.assertEquals('CreateBillingAccount', log.Webservice_Name__c);
        System.assertEquals(null, log.Original_Log__c);
        System.assertEquals('Outbound', log.Direction__c);
    }
    static testMethod void test_logOutboundReprocessException_UseCase1(){
        try{
            insert new Account();
        }catch(Exception exp) {
            LogIntegrationServices.logOutboundReprocessException(exp, 'TestClass', 'testMethod', null, 'Account', 'CreateBillingAccount', '', '', '', '', 0, null, 'Account', 'CreateBillingAccount', null);
        }
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c, Webservice_Name__c, Original_Log__c, Direction__c from Log__c limit 1];
        System.assertEquals('Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [Name]: [Name]', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
        System.assertEquals('Error Message: Required fields are missing: [Name]\nDML Failure Type: REQUIRED_FIELD_MISSING\nThe following fields caused the error: (Name)', log.Log_Details__c);
        System.assertEquals('CreateBillingAccount', log.Webservice_Name__c);
        System.assertEquals(null, log.Original_Log__c);
        System.assertEquals('Outbound', log.Direction__c);
    }
    static testMethod void test_logOutboundError_UseCase1(){
        LogIntegrationServices.logOutboundError('Something went wrong','TestClass','testMethod',null,'Account','CreateBillingAccount','','','','',0,null,'Account','CreateBillingAccount');
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c, Webservice_Name__c, Original_Log__c, Direction__c from Log__c limit 1];
        System.assertEquals('Something went wrong', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
        System.assertEquals(null, log.Log_Details__c);
        System.assertEquals('CreateBillingAccount', log.Webservice_Name__c);
        System.assertEquals(null, log.Original_Log__c);
        System.assertEquals('Outbound', log.Direction__c);
    }
    static testMethod void test_logOutboundReprocessError_UseCase1(){
        LogIntegrationServices.logOutboundReprocessError('Something went wrong','TestClass','testMethod',null,'Account','CreateBillingAccount','','','','',0,null,'Account','CreateBillingAccount', null);
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c, Webservice_Name__c, Original_Log__c, Direction__c from Log__c limit 1];
        System.assertEquals('Something went wrong', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
        System.assertEquals(null, log.Log_Details__c);
        System.assertEquals('CreateBillingAccount', log.Webservice_Name__c);
        System.assertEquals(null, log.Original_Log__c);
        System.assertEquals('Outbound', log.Direction__c);
    }
    static testMethod void test_logOutboundInfo_UseCase1(){
        LogIntegrationServices.logOutboundInfo('', 'TestClass','testMethod',null,'Account','CreateBillingAccount','','','','',0,null,'Account','CreateBillingAccount');
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c, Webservice_Name__c, Original_Log__c, Direction__c from Log__c limit 1];
        System.assertEquals(null, log.Result_Message__c);
        System.assertEquals('Outbound', log.Direction__c);
        System.assertEquals('Successful', log.Result_Status__c);
    }
    static testMethod void test_logOutboundReprocessInfo_UseCase1(){
        Log__c origLog = new Log__c();
        insert origLog;
        LogIntegrationServices.logOutboundReprocessInfo('', 'TestClass','testMethod',null,'Account','CreateBillingAccount','','','','',0,origLog.Id,'Account','CreateBillingAccount', null);
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c, Webservice_Name__c, Original_Log__c, Direction__c from Log__c where Id <> :origLog.Id limit 1];
        System.assertEquals(null, log.Result_Message__c);
        System.assertEquals('Outbound', log.Direction__c);
        System.assertEquals('Successful', log.Result_Status__c);
        System.assertNotEquals(null, log.Original_Log__c);
    }

    static testMethod void test_logError_UseCase1(){
        LogIntegrationServices.logError('Something went wrong','TestClass','testMethod',null,'Account','CreateBillingAccount','','','','', LogIntegrationServices.Direction.OUTBOUND,0,null, true,true,null, 'Account','CreateBillingAccount');
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c, Webservice_Name__c, Original_Log__c, Direction__c from Log__c limit 1];
        System.assertEquals('Something went wrong', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
        System.assertEquals('CreateBillingAccount', log.Webservice_Name__c);
        System.assertEquals(null, log.Original_Log__c);
        System.assertEquals('Outbound', log.Direction__c);
    }
    static testMethod void test_logException_UseCase1(){
        try{
            insert new Account();
        }catch(Exception exp) {
            LogIntegrationServices.logException(exp,'TestClass','testMethod',null,'Account','CreateBillingAccount','','','','', LogIntegrationServices.Direction.OUTBOUND,0,null, false,true,null, 'Account','CreateBillingAccount');
        }
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c, Webservice_Name__c, Original_Log__c, Direction__c from Log__c limit 1];
        System.assertEquals('Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [Name]: [Name]', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
        System.assertEquals('CreateBillingAccount', log.Webservice_Name__c);
        System.assertEquals(null, log.Original_Log__c);
        System.assertEquals('Outbound', log.Direction__c);
    }
    static testMethod void test_logInfo_UseCase1(){
        Log__c log = LogIntegrationServices.logInfo('', 'TestClass','testMethod',null,'Account','CreateBillingAccount','','','','', LogIntegrationServices.Direction.OUTBOUND,0,null,true,null, 'Account','CreateBillingAccount');
        System.assertEquals('', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Successful', log.Result_Status__c);
        System.assertEquals('CreateBillingAccount', log.Webservice_Name__c);
        System.assertEquals(null, log.Original_Log__c);
        System.assertEquals('Outbound', log.Direction__c);
    }
    static testMethod void test_buildIntegrationLog_UseCase1(){
        Log__c log;
        try{
            insert new Account();
        }catch(Exception exp) {
            log = LogIntegrationServices.buildIntegrationLog(exp,'TestClass','testMethod',null,'Account','CreateBillingAccount','','','','', LogIntegrationServices.Direction.OUTBOUND,0,null,true,null, 'Account','CreateBillingAccount');
        }
        System.assertEquals('Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [Name]: [Name]', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Successful', log.Result_Status__c);
        System.assertEquals('CreateBillingAccount', log.Webservice_Name__c);
        System.assertEquals(null, log.Original_Log__c);
        System.assertEquals('Outbound', log.Direction__c);
    }
    static testMethod void test_buildIntegrationLog_UseCase2(){
        Log__c log;
        log = LogIntegrationServices.buildIntegrationLog('Something went wrong','TestClass','testMethod',null,'Account','CreateBillingAccount','','','','', LogIntegrationServices.Direction.OUTBOUND,0,null,true,null, 'Account','CreateBillingAccount');
        System.assertEquals('Something went wrong', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Successful', log.Result_Status__c);
        System.assertEquals('CreateBillingAccount', log.Webservice_Name__c);
        System.assertEquals(null, log.Original_Log__c);
        System.assertEquals('Outbound', log.Direction__c);
    }
}