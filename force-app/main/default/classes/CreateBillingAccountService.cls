/**
 * @author Stepan Ruzicka
 * @date 27/10/2016
 * @description CreateBillingAccountService rest service creates billing account
 */

public class CreateBillingAccountService {
    static String serviceName = 'CreateBillingAccount';
    static String elementOfIterest = 'params';
    public static String createBillingAccounts(String json) {
    return '';
    }
/*
    public static String createBillingAccounts(String json) {
        String result = '';
        String jsonType = 'WebserviceTypes.AccountJSONParameters';

        //json = '{"params":{"amount":"300.0000","thresholdId":"2173","resourceId":"1","msisdn":447777123456},"headers":{"Accept":"application/json, text/plain","Content-Type":"application/json;charset=utf-8"}}';
        json = '{"params":{"vlocityCmtVCustomerPriority":"1","accountNumber":"12345","accountStatus":"1","roleType":"dummy","billingCity":"London","billingPostalCode":1,"billingState":"UK","billingCountry":"UK","vlocityCmtPremisesIdentifier":447777123456,"vlocityCmtBillingEmailAddress":"john.snow@gmail.com","phone":447777123456,"vlocityCmtPartyId":447777123456,"languageAbility":447777123456,"lastName":"Snow","name":"John Snow","firstName":"John","Salutation":447777123456},"params":{"vlocityCmtVCustomerPriority":"1","accountNumber":"12345","accountStatus":"1","roleType":"dummy","billingCity":"London","billingPostalCode":1,"billingState":"UK","billingCountry":"UK","vlocityCmtPremisesIdentifier":447777123456,"vlocityCmtBillingEmailAddress":"john.snow@gmail.com","phone":447777123456,"vlocityCmtPartyId":447777123456,"languageAbility":447777123456,"lastName":"Snow","name":"John Snow","firstName":"John","Salutation":447777123456},"headers":{"Accept":"application/json, text/plain","Content-Type":"application/json;charset=utf-8"}}';

        List<WebserviceType> accountParametersList = (List<WebserviceType>)parseJSONObjectList(jsonType, json);
System.debug('accountParametersList je: ' + accountParametersList);
        for(WebserviceType parameters: accountParametersList){
            result += createBillingAccount((WebserviceTypes.AccountJSONParameters)parameters) + '\n';
            // TODO: Logging
        }
        
        for(WebserviceTypes.AccountJSONParameters parameters: accountParametersList){
            result += createBillingAccount(parameters) + '\n';
            // TODO: Logging
        }
        
        return result;
    }

    public static List<WebserviceTypes.WebserviceType> parseJSONObjectList(String jsonType, String jsonObjectList){
        Type jsonTypeObject = Type.forName(jsonType);
        Type jsonListTypeObject = Type.forName('List<' + jsonType + '>');

        JSONParser parser = JSON.createParser(jsonObjectList);
        List<WebserviceType> resultList = new List<WebserviceType>();
        WebserviceType params = (WebserviceType)jsonTypeObject.newInstance();

        while(parser.nextToken() != null) {
            // System.debug(parser.getCurrentName());
            if((parser.getCurrentName() == elementOfIterest)){
                parser.nextToken();
                // TODO: Try-Catch
                params = (WebserviceType)parser.readValueAs(jsonTypeObject);
                resultList.add(params);
                System.debug('params: ' + params);
            }
        }

        return resultList;
    }

    public static String createBillingAccount(WebserviceTypes.AccountJSONParameters params){
        WebServices_CS__c webserviceSetting = WebServices_CS__c.getInstance(serviceName);
        // call SOAP webservice
        CreateBillingAccountApi.CreateBillingAccount_WS_CreateBillingAccountHttpPort socket = new CreateBillingAccountApi.CreateBillingAccount_WS_CreateBillingAccountHttpPort();
        // socket.endpoint_x = 'http://92.103.147.161:9080/TPDemoWeb/sca/CreateBillingAccountExport_WS';
        socket.endpoint_x = webserviceSetting.Endpoint_URL__c;
        //socket.endpoint_x = http://putsreq.com/efl5xOm3hF45Al1JYVeN';
        CreateBillingAccountApiTypes.msg_CustomerAccount createBillingAccountMessage = new CreateBillingAccountApiTypes.msg_CustomerAccount();
        createBillingAccountMessage.Header = WebserviceUtils.createMatrixxHeader(serviceName, 0);
        createBillingAccountMessage.Payload = WebserviceUtils.createCreateBillingAccountBody(params);

        CreateBillingAccountApiTypes.msg_CustomerAccount result = socket.invoke(createBillingAccountMessage);
        System.debug('response: ' + JSON.serialize(result));
        return JSON.serialize(result);
    }
   
    @HttpPost
    global static String CreateBillingAccount(){

        JSONParser parser = JSON.createParser(RestContext.request.requestBody.toString());

        // Example: Formatted JSON Data {"params":{"amount":"300.0000","thresholdId":"2173","resourceId":"1","msisdn":447777123456},"headers":{"Accept":"application/json, text/plain","Content-Type":"application/json;charset=utf-8"}}
        AccountJSONParameters params;

        while(parser.nextToken() != null) {
            System.debug(parser.getCurrentName());
            if((parser.getCurrentName() == 'params')){
                parser.nextToken();
                params = (AccountJSONParameters)parser.readValueAs(AccountJSONParameters.class);
            }
        }

        // call SOAP webservice
        CreateBillingAccountApi.CreateBillingAccount_WS_CreateBillingAccountHttpPort socket = new CreateBillingAccountApi.CreateBillingAccount_WS_CreateBillingAccountHttpPort();
        socket.endpoint_x = 'http://92.103.147.161:9080/TPDemoWeb/sca/CreateBillingAccountExport_WS';
        //socket.endpoint_x = http://putsreq.com/efl5xOm3hF45Al1JYVeN';
        CreateBillingAccountApiTypes.msg_CustomerAccount createBillingAccountMessage = new CreateBillingAccountApiTypes.msg_CustomerAccount();
        createBillingAccountMessage.Header = UtilsWebservice.createMatrixxHeader('CreateBillingAccount', params);
        createBillingAccountMessage.Payload = UtilsWebservice.createCreateBillingAccountBody(params);

        CreateBillingAccountApiTypes.msg_CustomerAccount result = socket.invoke(createBillingAccountMessage);
System.debug('response: ' + JSON.serialize(result));
        return JSON.serialize(result);

        //return '';
    }

    global with sharing class AccountJSONParameters {
        public String vlocityCmtVCustomerPriority;
        public String accountNumber;
        public String accountStatus;
        public String roleType;
        public String billingCity;
        public String billingPostalCode;
        public String billingState;
        public String billingCountry;
        public String vlocityCmtPremisesIdentifier;
        public String vlocityCmtBillingEmailAddress;
        public String phone;
        public String vlocityCmtPartyId;
        public String languageAbility;
        public String name;
        public String lastName;
        public String firstName;
        public String Salutation;
        public String uniqueBillSpecID;
        public String billFormatID;
        public String paperlessBilling;
        public String billingDate;
        public String billingPeriodName;
    }
    */
}