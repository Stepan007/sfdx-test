@isTest
private class LogServices_Test{
    static testMethod void test_logError_UseCase1(){
        LogServices.logError('Something went wrong','TestClass');
        List<Log__c> logList = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c from Log__c];
        Log__c log = logList.get(0);
        System.assertEquals('Something went wrong', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals(null, log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
    }
    static testMethod void test_logError_UseCase2(){
        LogServices.logError('Something went wrong','TestClass','testMethod');
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c from Log__c limit 1];
        System.assertEquals('Something went wrong', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
    }
    static testMethod void test_logError_UseCase3(){
        LogServices.logError('Something went wrong','TestClass','testMethod',true);
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c from Log__c limit 1];
        System.assertEquals('Something went wrong', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
    }
    static testMethod void test_logError_UseCase4(){
        try{
            insert new Account();
        }catch(Exception exp){
            LogServices.logError(exp,'TestClass');
        }
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c from Log__c limit 1];
        System.assertEquals('Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [Name]: [Name]', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals(null, log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
    }
    static testMethod void test_logError_UseCase5(){
        try{
            insert new Account();
        }catch(Exception exp){
            LogServices.logError(exp,'TestClass','testMethod',true);
        }
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c from Log__c limit 1];
        System.assertEquals('Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [Name]: [Name]', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
    }
    static testMethod void test_logError_UseCase6(){
        try{
            insert new Account();
        }catch(Exception exp){
            LogServices.logError(exp,'TestClass','testMethod');
        }
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c from Log__c limit 1];
        System.assertEquals('Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [Name]: [Name]', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
    }
    static testMethod void test_logError_UseCase7(){
        try{
            insert new Account();
        }catch(Exception exp){
            LogServices.logError(exp,'TestClass','testMethod','',true);
        }
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c from Log__c limit 1];
        System.assertEquals('Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [Name]: [Name]', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
    }
    static testMethod void test_SaveResult_UseCase8(){
        List<Account> accountList = new List<Account>{new Account()};
        Database.SaveResult[] srList = Database.insert(accountList, false);
        LogServices.LogError(srList,'TestClass','testMethod');
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c from Log__c limit 1];
        System.assertEquals('Error(s) Encountered. Please refer to the Log Details field for additional info.', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
        System.assertEquals('The following error(s) ocurred:\nRequired fields are missing: [Name].\nThe following field(s) caused the error: Name', log.Log_Details__c);
    }
    static testMethod void test_SaveResult_UseCase9(){
        List<Account> accountList = new List<Account>{new Account()};
        Database.SaveResult[] srList = Database.insert(accountList, false);
        LogServices.LogError(srList,'TestClass');
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c from Log__c limit 1];
        System.assertEquals('Error(s) Encountered. Please refer to the Log Details field for additional info.', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals(null, log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
        System.assertEquals('The following error(s) ocurred:\nRequired fields are missing: [Name].\nThe following field(s) caused the error: Name', log.Log_Details__c);

    }
    static testMethod void test_SaveResult_UseCase10(){
        List<Account> accountList = new List<Account>{new Account()};
        Database.SaveResult[] srList = Database.insert(accountList, false);
        LogServices.LogError(srList,'TestClass','testMethod',true);
        Log__c log = [select Id, Result_Message__c, Class_Name__c, Method_Name__c, Result_Status__c, Log_Details__c from Log__c limit 1];
        System.assertEquals('Error(s) Encountered. Please refer to the Log Details field for additional info.', log.Result_Message__c);
        System.assertEquals('TestClass', log.Class_Name__c);
        System.assertEquals('testMethod', log.Method_Name__c);
        System.assertEquals('Unsuccessful', log.Result_Status__c);
        System.assertEquals('The following error(s) ocurred:\nRequired fields are missing: [Name].\nThe following field(s) caused the error: Name', log.Log_Details__c);
    }
}