@isTest
private class WebServiceTemplate2_Test{
    @testSetup
    static void setupTestData(){

    }
    static testMethod void test_constructor(){
        WebserviceTemplate2 webServiceTemplate2 = new WebserviceTemplate2();
    }
    static testMethod void test_constructor2(){
        WebserviceTemplate2 webServiceTemplate2 = new WebserviceTemplate2('TestClass', 'TestMethod');

    }
}