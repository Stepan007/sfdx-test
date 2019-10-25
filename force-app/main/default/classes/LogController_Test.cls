@isTest
private class LogController_Test{
    @testSetup
    static void setupTestData(){
        Test.startTest();
        Log__c log_Obj = new Log__c();
        log_Obj.User__c = UserInfo.getUserId();
        log_Obj.Type__c = 'Integration';
        log_Obj.Class_Name__c = 'TestClass';
        log_Obj.Method_Name__c = 'testMethod';
        Insert log_Obj;

        Test.stopTest();
    }
    static testMethod void test_reprocessSelectedRecords_UseCase1(){
        LogController controller = new LogController();
        Test.setCurrentPageReference(new PageReference('Page.ReprocessButton'));
        List<Log__c> logList  =  [SELECT Id,User__c,Original_Log__c,Type__c from Log__c];
        String origLogId = logList.get(0).id;
        System.currentPageReference().getParameters().put('recs', origLogId);
        controller.reprocessSelectedRecords();
        List<Log__c> logList1  =  [SELECT Id,User__c,Original_Log__c,Type__c,Class_Name__c,Method_Name__c from Log__c where Id <> :origLogId];
        System.assertEquals(1, logList1.size());
        System.assertEquals(origLogId, logList1.get(0).Original_Log__c);
        System.assertEquals('Integration', logList1.get(0).Type__c);
        System.assertEquals('TestClass', logList1.get(0).Class_Name__c);
        System.assertEquals('testMethod', logList1.get(0).Method_Name__c);
    }
}