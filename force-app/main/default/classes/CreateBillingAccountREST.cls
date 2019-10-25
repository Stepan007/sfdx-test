/**
 * @author Stepan Ruzicka
 * @date 20/04/2017
 * @description CreateBillingAccount REST service creates billing account in Matrixx system
 */

@RestResource(urlMapping='/createBillingAccount/*')
global class CreateBillingAccountREST {

    @HttpPost
    global static String createBillingAccount(){
        System.debug('CreateBillingAccountREST');
        // Example: Formatted JSON Data {"params":{"amount":"300.0000","thresholdId":"2173","resourceId":"1","msisdn":447777123456},"headers":{"Accept":"application/json, text/plain","Content-Type":"application/json;charset=utf-8"}}
        return CreateBillingAccountService.createBillingAccounts(RestContext.request.requestBody.toString());

        // TODO: Logging
    }
}