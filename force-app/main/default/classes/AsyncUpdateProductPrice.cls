public class AsyncUpdateProductPrice {
    public class dummy_elementFuture extends System.WebServiceCalloutFuture {
        public String getValue() {
            UpdateProductPrice.dummy_element response = (UpdateProductPrice.dummy_element)System.WebServiceCallout.endInvoke(this);
            return response.inputParam;
        }
    }
    public class AsyncupdateProductPriceHttpPort {
        public String endpoint_x = 'https://http://www.examples.com/updateProductPrice';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://updateProductPrice', 'UpdateProductPrice'};
        public AsyncUpdateProductPrice.dummy_elementFuture beginUpdateProductPrice(System.Continuation continuation,UpdateProductPrice.ProductOfferingSpecification[] productOfferingSpecifications,UpdateProductPrice.SpecificationVersion specificationVersion) {
            UpdateProductPrice.VLocityExport request_x = new UpdateProductPrice.VLocityExport();
            request_x.productOfferingSpecifications = productOfferingSpecifications;
            request_x.specificationVersion = specificationVersion;
            return (AsyncUpdateProductPrice.dummy_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncUpdateProductPrice.dummy_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://updateProductPrice',
              'VLocityExport',
              'http://updateProductPrice',
              'dummy',
              'UpdateProductPrice.dummy_element'}
            );
        }
    }
}
