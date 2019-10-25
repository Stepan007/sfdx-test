//Generated by wsdl2apex

public class SubmitCustomerOrderApi {
    public class SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort {
        public String endpoint_x = 'http://localhost:9080/TestWeb/sca/SubmitCustomerOrder_WS';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://www.ibm.com/software/issw/telecom/pack/v8.5.0/lite/businessobject/system/fulfillment/extension', 'SubmitCustomerOrderApiTypes', 'http://TPCRMAI/AIS/SubmitCustomerOrder', 'SubmitCustomerOrderApi', 'http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/messageview', 'SubmitCustomerOrderApiTypes', 'http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/systemview', 'SubmitCustomerOrderApiTypes', 'http://www.ibm.com/software/issw/telecom/pack/v8.5.0/lite/businessobject/system/assurance/extension', 'SubmitCustomerOrderApiTypes', 'http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/fulfillment/extensions', 'SubmitCustomerOrderApiTypes', 'http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/assurance/extensions', 'SubmitCustomerOrderApiTypes', 'http://www.ibm.com/software/issw/telecom/pack/v8.5.0/lite/businessobject/system/sid-v12.5', 'SubmitCustomerOrderApiTypes', 'http://www.ibm.com/software/issw/telecom/pack/v8.5.0/lite/businessobject/system/common/extension', 'SubmitCustomerOrderApiTypes', 'http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/billing/extensions', 'SubmitCustomerOrderApiTypes', 'http://TPCMN', 'SubmitCustomerOrderApiTypes', 'http://www.ibm.com/software/issw/telecom/pack/v8.5.0/lite/businessobject/system/billing/extension', 'SubmitCustomerOrderApiTypes', 'http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common', 'SubmitCustomerOrderApiTypes', 'http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common/extensions', 'SubmitCustomerOrderApiTypes'};
        public SubmitCustomerOrderApiTypes.msg_CustomerOrder invoke(SubmitCustomerOrderApiTypes.msg_CustomerOrder submitCustomerOrderInput) {
            SubmitCustomerOrderApiTypes.invoke_element request_x = new SubmitCustomerOrderApiTypes.invoke_element();
            request_x.submitCustomerOrderInput = submitCustomerOrderInput;
            SubmitCustomerOrderApiTypes.invokeResponse_element response_x;
            Map<String, SubmitCustomerOrderApiTypes.invokeResponse_element> response_map_x = new Map<String, SubmitCustomerOrderApiTypes.invokeResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '',
              'http://TPCRMAI/AIS/SubmitCustomerOrder',
              'invoke',
              'http://TPCRMAI/AIS/SubmitCustomerOrder',
              'invokeResponse',
              'SubmitCustomerOrderApiTypes.invokeResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.submitCustomerOrderOutput;
        }
    }
}