@isTest
private class IntegrationFrameworkUtils_Test{
    @testSetup
    static void setupTestData(){
        test.startTest();
        Log__c log_Obj = new Log__c();
        log_Obj.User__c = UserInfo.getUserId();
        log_Obj.Type__c = 'Integration';
        log_Obj.Class_Name__c = 'TestClass';
        log_Obj.Method_Name__c = 'testMethod';
        Insert log_Obj;

        Global_Correlation_Id__c setting = new Global_Correlation_Id__c();
        setting.Name = IntegrationFrameworkUtils.GLOBAL_CORRELATION_SETTING_NAME;
        insert setting;

        test.stopTest();
    }
    static testMethod void test_increaseAndGetCorrelationId_UseCase1(){
        Integer correlationId = IntegrationFrameworkUtils.increaseAndGetCorrelationId();
        System.assertEquals(correlationId, 1);
    }
    static testMethod void test_increaseGetAndUpdateCorrelationId_UseCase1(){
        Integer correlationId = IntegrationFrameworkUtils.increaseAndGetCorrelationId();
        System.assertEquals(correlationId, 1);
    }
    static testMethod void test_reprocess_UseCase1(){
        List<Log__c> logList  =  [SELECT Id,User__c,Original_Log__c,Type__c from Log__c];
        String origLogId = logList.get(0).Id;
        IntegrationFrameworkUtils.reprocess(new Set<String>{origLogId});
        List<Log__c> logList1  =  [SELECT Id,User__c,Original_Log__c,Type__c,Class_Name__c,Method_Name__c from Log__c where Id <> :origLogId];
        System.assertEquals(origLogId, logList1.get(0).Original_Log__c);
        System.assertEquals('Integration', logList1.get(0).Type__c);
        System.assertEquals('TestClass', logList1.get(0).Class_Name__c);
        System.assertEquals('testMethod', logList1.get(0).Method_Name__c);
    }
}