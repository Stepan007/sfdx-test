@isTest
private class LogServicesCommon_Test{
    @testSetup
    static void setupTestData(){

    }

    static testMethod void test_persistLogs_UseCase1(){
        LogServicesCommon.persistLogs();
    }
    static testMethod void test_loggingIsOn_UseCase1(){
        LogServicesCommon.generatedLogs = new List<Log__c>();
        System.assertEquals(true, LogServicesCommon.loggingIsOn('TestClass', 'testMethod', true));
    }
    static testMethod void test_loggingIsOn_UseCase2(){
        LogServicesCommon.generatedLogs = new List<Log__c>();
        System.assertEquals(true, LogServicesCommon.loggingIsOn('TestClass', 'testMethod'));
    }
    static testMethod void test_loggingIsOn_UseCase3(){
        LogServicesCommon.generatedLogs = new List<Log__c>();
        System.assertEquals(true, LogServicesCommon.loggingIsOn('TestClass', true));
    }
    static testMethod void test_loggingIsOn_UseCase4(){
        LogServicesCommon.generatedLogs = new List<Log__c>();
        System.assertEquals(true, LogServicesCommon.loggingIsOn('TestClass'));
    }
    static testMethod void test_getLogRecordType_UseCase1(){
        System.assertNotEquals(null, LogServicesCommon.getLogRecordType('Standard'));
    }
    static testMethod void test_getRecordType_UseCase1(){
        System.assertNotEquals(null, LogServicesCommon.getRecordType('Log__c','Integration'));
    }
    static testMethod void test_buildBaseLogFromException_UseCase1(){
        Log__c log;
        try{
            insert new Account();
        }catch(Exception exp){
            log = LogServicesCommon.buildBaseLogFromException(exp,'TestClass', 'testMethod', false, 'Integration');
        }
        System.assertEquals('TestClass',log.Class_Name__c);
        System.assertEquals('testMethod',log.Method_Name__c);
    }
    static testMethod void test_buildBaseLogFromException_UseCase2(){
        Log__c log;
        try{
            insert new Account();
        }catch(Exception exp){
            log = LogServicesCommon.buildBaseLogFromException(exp, 'TestClass', 'testMethod');
        }
        System.assertEquals('TestClass',log.Class_Name__c);
        System.assertEquals('testMethod',log.Method_Name__c);
    }
    static testMethod void test_buildBaseLogFromException_UseCase3(){
        Log__c log;
        try{
            insert new Account();
        }catch(Exception exp){
            log = LogServicesCommon.buildBaseLogFromException(exp, 'TestClass');
        }
        System.assertEquals('TestClass',log.Class_Name__c);
        System.assertEquals('',log.Method_Name__c);
    }
    static testMethod void test_buildBaseLog_UseCase1(){
        Log__c log;
        log = LogServicesCommon.buildBaseLog('Something went wrong', 'TestClass', 'testMethod', false, 'Standard');
        System.assertEquals('TestClass',log.Class_Name__c);
        System.assertEquals('testMethod',log.Method_Name__c);
        System.assertEquals('Something went wrong',log.Result_Message__c);
    }
    static testMethod void test_buildBaseLog_UseCase2(){
        Log__c log;
        log = LogServicesCommon.buildBaseLog('Something went wrong', 'TestClass');
        System.assertEquals('TestClass',log.Class_Name__c);
        System.assertEquals('',log.Method_Name__c);
        System.assertEquals('Something went wrong',log.Result_Message__c);
    }
    static testMethod void test_buildBaseLog_UseCase3(){
        Log__c log;
        log = LogServicesCommon.buildBaseLog('Something went wrong', 'TestClass', 'testMethod');
        System.assertEquals('TestClass',log.Class_Name__c);
        System.assertEquals('testMethod',log.Method_Name__c);
        System.assertEquals('Something went wrong',log.Result_Message__c);
    }
    static testMethod void test_logDMLError_UseCase4(){
        Log__c log;
        try{
            insert new Account();
        }catch(DmlException exp){
            log = new Log__c();
            LogServicesCommon.logDMLError(exp, log);
        }
        System.assertEquals(null,log.Class_Name__c);
        System.assertEquals(null,log.Method_Name__c);
        String logDetailsSubstr = log.Log_Details__c.substring(0, 42);
        System.assertEquals('Error Message: Required fields are missing',logDetailsSubstr);
    }
    static testMethod void test_logSaveResultError_UseCase1(){
        List<Account> accountList = new List<Account>{new Account()};
        Database.SaveResult[] srList = Database.insert(accountList, false);
        Log__c log = new Log__c();
        LogServicesCommon.logSaveResultError(srList.get(0), log);
        System.assertEquals(null, log.Result_Message__c);
        System.assertEquals(null, log.Class_Name__c);
        System.assertEquals(null, log.Method_Name__c);
        System.assertEquals(null, log.Result_Status__c);
        String logDetailsSubstr = log.Log_Details__c.substring(0, 30);
        System.assertEquals('The following error(s) ocurred', logDetailsSubstr);
    }
}