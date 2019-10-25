@isTest
private class WebServiceTemplate_Test{
    @testSetup
    static void setupTestData(){

    }
    static testMethod void test_constructor(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate();
    }

    static testMethod void test_createConnection(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('WebServiceTemplate', 'templateMethod');
        webServiceTemplate.createConnection(null);
        System.assertEquals(null, webServiceTemplate.createConnection(null));
    }
    static testMethod void test_createRequest(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('WebServiceTemplate', 'templateMethod');
        System.assertEquals(null, webServiceTemplate.createRequest(null));
    }
    static testMethod void test_invoke(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('WebServiceTemplate', 'templateMethod');
        System.assertEquals(null, webServiceTemplate.invoke(webServiceTemplate.createConnection(null), webServiceTemplate.createRequest(null)));
    }
    static testMethod void test_invoke2(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('WebServiceTemplate', 'templateMethod');
        System.assertEquals(null, webServiceTemplate.invoke('', ''));
    }
    static testMethod void test_processResponse(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('WebServiceTemplate', 'templateMethod');
        System.assertEquals(null, webServiceTemplate.processResponse(webServiceTemplate.createRequest(null), webServiceTemplate.invoke(webServiceTemplate.createConnection(null), webServiceTemplate.createRequest(null))));
    }
    static testMethod void test_getLogValues_UseCase1(){
        WebServiceTemplate webServiceTemplate = new WebServiceTemplate('WebServiceTemplate', 'templateMethod');
        Map<String, String> valuesMap = webServiceTemplate.getLogValues(webServiceTemplate.createRequest(null), webServiceTemplate.invoke(webServiceTemplate.createConnection(null), webServiceTemplate.createRequest(null)));
        System.assertEquals('', valuesMap.get('sfObjectId'));
    }
}