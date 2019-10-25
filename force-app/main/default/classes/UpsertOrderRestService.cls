@RestResource(urlMapping='/InsertOrderList/*')
global with sharing class  UpsertOrderRestService{
	public UpsertOrderRestService(){
		
	}

	@HttpPost
	global static List<OrderObjectJSON> insertOrderList(List<OrderObjectJSON> req){
		return req;
	}

    global class OrderObjectJSON{
        public String orderId;
        public String orderName;
    }
}