public class HttpCalloutSample {

  // Pass in the endpoint to be used using the string url
  public String getCalloutResponseContents(String msisdn) {

        HTTP objhttp = new Http();
        HTTPRequest req = new HttpRequest();
        HTTPResponse res = new HttpResponse();
        req.setMethod('POST'); 
        req.setEndpoint('http://92.103.147.65:8080/rsgateway/data/v3/');

        String reqBody =    '<MtxRequestMulti>' +
                                '<RequestList>' +
                                    '<MtxRequestSubscriberQueryWallet>' +
                                        '<SubscriberSearchData>' +
                                            '<MtxSubscriberSearchData>' +
                                                '<AccessNumber>msisdn</AccessNumber>' +
                                            '</MtxSubscriberSearchData>' +
                                        '</SubscriberSearchData>' +
                                    '</MtxRequestSubscriberQueryWallet>' +
                                '</RequestList>' +
                            '</MtxRequestMulti>';
        req.setBody(reqBody);

        res = objhttp.send(req);
        return res.getBody();
  }
}