/**
  * @author Stepan Ruzicka
  * @date 16.06.2017
  *
  * @description
  */
public with sharing class WebServiceTemplate extends WebServiceVirtualClass{
    /**
     * Default constructor
     */
    public WebServiceTemplate(){
        super();
    }

    /**
     * @description Constructor where the user class name and user method name is set (for logging purposes)
     * @param User class name
     * @param User method name
     */
    public WebServiceTemplate(String userClassName, String userMethodName){
        super(userClassName, userMethodName);
    }

    public override Object createConnection(Object input){
        // declare and define connection e.g.
        // SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort connection = new SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort();

        // set the endpoint e.g.
        // connection.endpoint_x = 'http://putsreq.com/TAHdGIlvsdPCSbC6Ad09';

        // return connection e.g.
        // return connection;
        return null;
    }

    public override Object createRequest(Object input){
        // declare and define message e.g.
        // SubmitCustomerOrderApiTypes.msg_CustomerOrder submitCustomerOrderRequest = new SubmitCustomerOrderApiTypes.msg_CustomerOrder();

        // populate header e.g.
        // submitCustomerOrderRequest.Header = createHeader(input);

        // populate body e.g.
        // submitCustomerOrderRequest.Payload = createBody(input);

        // return message e.g.
        // return submitCustomerOrderRequest;
        return null;
    }

    public override Object invoke(Object connection, Object request){
        // declare response e.g.
        // SubmitCustomerOrderApiTypes.msg_CustomerOrder response;

        // cast objects to concrete types e.g.
        // SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort submitCustomerOrderConnection = (SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort) connection;
        // SubmitCustomerOrderApiTypes.msg_CustomerOrder submitCustomerOrderRequest = (SubmitCustomerOrderApiTypes.msg_CustomerOrder) request;

        // declare response type
        // Boolean processedResponse;

        // set correlation ID
        // setCorrelationId();

        try{
            // invoke webservice e.g.
            // response = submitCustomerOrderConnection.invoke(submitCustomerOrderRequest);
        }catch(Exception exp){
            // log error e.g.
            // logError(exp, connection, request, response);
            return null;
        }

        try{
            // process the response
            // processedResponse = (Boolean)processResponse(request, response);
        }catch(Exception exp){
            // log error e.g.
            // logError(exp, connection, request, response);
            return null;
        }

        // log success e.g.
        // logInfo(request, response);

        // return response e.g.
        // return processedResponse;
        return null;
    }

    public override String invoke(String connection, String request){
        String responseStr;

        // declare concrete objects of concrete types e.g.
        // SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort submitCustomerOrderConnection;
        // SubmitCustomerOrderApiTypes.msg_CustomerOrder submitCustomerOrderRequest;
        // SubmitCustomerOrderApiTypes.msg_CustomerOrder response;

        try{
            // deserialize JSON parameters e.g.
            // submitCustomerOrderConnection = (SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort)JSON.deserialize(connection, SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort.class);
            // submitCustomerOrderRequest = (SubmitCustomerOrderApiTypes.msg_CustomerOrder)JSON.deserialize(request, SubmitCustomerOrderApiTypes.msg_CustomerOrder.class);
        }catch(System.Exception e){
            logError(e, connection, request, null);
            return '';
        }

        // call invoke with deserialized objects as parameters
        // e.g. response = (SubmitCustomerOrderApiTypes.msg_CustomerOrder)invoke(submitCustomerOrderConnection, submitCustomerOrderRequest);

        // serialize the response
        // e.g. responseStr = JSON.serialize(response);

        return responseStr;
    }

    public override Object processResponse(Object request, Object response){
        
        // go through your request and response and process the returned data

        return null;
    }

    public override Map<String, String> getLogValues(Object request, Object response){
        Map<String, String> logValues = new Map<String, String>();

        // go through your request and response and populate the map below

        logValues.put('sfObjectId', '');
        logValues.put('sfObjectType', '');
        logValues.put('externalObjectId', '');
        logValues.put('externalObjectType', '');
        logValues.put('resultCode', '');
        logValues.put('resultHeader', '');
        logValues.put('resultMessage', '');

        return logValues;
    }

    /************************************************ Utils ***********************************************************/

    // space for your helper methods
}