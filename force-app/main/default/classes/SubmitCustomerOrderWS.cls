/**
  * @author Stepan Ruzicka
  * @date 06.06.2017
  *
  * @description
  */

public with sharing class SubmitCustomerOrderWS extends WebServiceVirtualClass{
    private static final String DEFAULT_MSG_TYPE = 'REQUEST';
    private static final String DEFAULT_PRIORITY = '1';
    private static final String DEFAULT_SOURCE = 'VlocityOn';
    /**
     * Default constructor
     */
    public SubmitCustomerOrderWS(){
        super();
    }

    /**
     * @description Constructor where the user class name and user method name is set (for logging purposes)
     * @param User class name
     * @param User method name
     */
    public SubmitCustomerOrderWS(String userClassName, String userMethodName){
        super(userClassName, userMethodName);
    }

    public override Object createConnection(Object input){
        // create the connection
        SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort connection = new SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort();
        // set the endpoint
        connection.endpoint_x = getEndpointURL();
        return connection;
    }

    public override Object createRequest(Object input){
        // create the message
        SubmitCustomerOrderApiTypes.msg_CustomerOrder submitCustomerOrderRequest = new SubmitCustomerOrderApiTypes.msg_CustomerOrder();
        // populate header
        submitCustomerOrderRequest.Header = createHeader(input);
        submitCustomerOrderRequest.Payload = createBody(input);
        return submitCustomerOrderRequest;
    }

    public SubmitCustomerOrderApiTypes.Header createHeader(Object input){
        SubmitCustomerOrderApiTypes.Header header;

        SubmitCustomerOrderApiTypes.Header submitCustomerOrderHeader = new SubmitCustomerOrderApiTypes.Header();
        submitCustomerOrderHeader.CorrelationId_T = correlationId + '';
        submitCustomerOrderHeader.ActivityName_T = externalWebserviceName;
        submitCustomerOrderHeader.MsgType_T = DEFAULT_MSG_TYPE;
        submitCustomerOrderHeader.Priority_T = DEFAULT_PRIORITY;
        submitCustomerOrderHeader.Source = DEFAULT_SOURCE;
        submitCustomerOrderHeader.Timestamp = System.now();
        return submitCustomerOrderHeader;

        return header;
    }

    public List<SubmitCustomerOrderApiTypes.CustomerOrder> createBody(Object input){
        List<Order> orderList = (List<Order>) input;
        List<SubmitCustomerOrderApiTypes.CustomerOrder> payload = new List<SubmitCustomerOrderApiTypes.CustomerOrder>();

        SubmitCustomerOrderApiTypes.CustomerOrder customerOrder;

        for(Order theOrder: orderList){
            customerOrder = new SubmitCustomerOrderApiTypes.CustomerOrder();
            // START Payload.ID
            customerOrder.Id = new SubmitCustomerOrderApiTypes.IBMTelecomRootObject();
            customerOrder.Id.ID = String.valueOf(correlationId);
            customerOrder.Id.name = theOrder.Name;
            customerOrder.Id.type_x = '';
            customerOrder.Id.description = '';
            // START Payload.ID.ValidFor
            customerOrder.Id.ValidFor = new SubmitCustomerOrderApiTypes.TimePeriod();
            customerOrder.Id.ValidFor.startDate = System.now();
            customerOrder.Id.ValidFor.endDate = System.now();
            // END Payload.ID.ValidFor
            // END Payload.ID

            customerOrder.purchaseOrderNumber = String.valueOf(correlationId);
            customerOrder.customerOrderType = 'ProductOrder';
            customerOrder.dueDate = System.now(); // TODO: theOrder.Due_Date__c;

            // START Payload.Request
            customerOrder.Request = new SubmitCustomerOrderApiTypes.BusinessInteraction();
            customerOrder.Request.interactionType = 'Customer Order';
            customerOrder.Request.interactionDate = System.now();
            // customerOrder.Request.interactionDateComplete = '';
            customerOrder.Request.interactionStatus = '';
            customerOrder.Request.description = new List<String>();
            customerOrder.Request.description.add('');

            // START Payload.Request.CustomerAccountInteractionRole
            customerOrder.Request.CustomerAccountInteractionRole = new List<SubmitCustomerOrderApiTypes.CustomerAccount>();
            SubmitCustomerOrderApiTypes.CustomerAccount customerAccountInteractionRole1 = new SubmitCustomerOrderApiTypes.CustomerAccount();
            // START Payload.Request.CustomerAccountInteractionRole.ID
            customerAccountInteractionRole1.ID = new SubmitCustomerOrderApiTypes.IBMTelecomRootObject();
            customerAccountInteractionRole1.ID.ID = ''; // TODO: theOrder.Account.Account_Number__c;
            customerAccountInteractionRole1.ID.name = '';
            // END Payload.Request.CustomerAccountInteractionRole.ID

            customerAccountInteractionRole1.accountType = '';
            // START Payload.Request.CustomerAccountInteractionRole.CustomerAccountPartyRole
            customerAccountInteractionRole1.CustomerAccountPartyRole = new List<SubmitCustomerOrderApiTypes.PartyRole>();
            SubmitCustomerOrderApiTypes.PartyRole customerAccountPartyRole1 = new SubmitCustomerOrderApiTypes.PartyRole();
            customerAccountPartyRole1.ID = new SubmitCustomerOrderApiTypes.IBMTelecomRootObject();
            customerAccountPartyRole1.ID.ID = '';
            customerAccountPartyRole1.ID.name = '';
            customerAccountPartyRole1.roleType = 'PrimaryCustomer';
            customerAccountPartyRole1.Party = new SubmitCustomerOrderApiTypes.Party();
            customerAccountPartyRole1.Party.partyID = '';
            customerAccountInteractionRole1.CustomerAccountPartyRole.add(customerAccountPartyRole1);
            // END Payload.Request.CustomerAccountInteractionRole.CustomerAccountPartyRole
            customerOrder.Request.CustomerAccountInteractionRole.add(customerAccountInteractionRole1);
            // END Payload.Request.CustomerAccountInteractionRole
            // END Payload.Request

            // START Payload.CustomerOrder.CustomerOrderItem
            customerOrder.CustomerOrderItem = new List<SubmitCustomerOrderApiTypes.CustomerOrderItem>();

            Map<Id, Asset> assetOrderItemMap = getAssetMapForOrderItem(theOrder.Id);
            //Map<Id, Map<Id, Product2>> orderItemProductMap = getSubProductsForOrderItems(theOrder.OrderItems);
            Map<Id, VlocityOrderItem> orderItemHierarchy = createOrderItemHierarchy(theOrder.OrderItems);

            Integer counter = 0;
            OrderItem theOrderItem;
            //for(OrderItem theOrderItem: theOrder.OrderItems){
            for(Id vlocityOrderItemId: orderItemHierarchy.keySet()){
                counter = counter + 1;
                theOrderItem = orderItemHierarchy.get(vlocityOrderItemId).orderItem;

                SubmitCustomerOrderApiTypes.CustomerOrderItem customerOrderItem = new SubmitCustomerOrderApiTypes.CustomerOrderItem();
                // START Payload.CustomerOrder.CustomerOrderItem.ID
                customerOrderItem.ID = new SubmitCustomerOrderApiTypes.IBMTelecomRootObject();
                customerOrderItem.ID.ID = counter + '';
                customerOrderItem.ID.name = theOrderItem.Description;
                // END Payload.CustomerOrder.CustomerOrderItem.ID

                // START Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem
                customerOrderItem.BusinessInteractionItem = new SubmitCustomerOrderApiTypes.BusinessInteractionItem();
                customerOrderItem.BusinessInteractionItem.quantity = (Integer)theOrderItem.Quantity + '';
                /* TODO

                if(theOrderItem.vlocity_cmt__ProvisioningStatus__c != null && theOrderItem.vlocity_cmt__ProvisioningStatus__c == 'New'){
                    customerOrderItem.BusinessInteractionItem.action = 'ADD';
                    customerOrderItem.BusinessInteractionItem.verb = 'ADD_NEW';
                }else if(theOrderItem.vlocity_cmt__ProvisioningStatus__c == 'Deleted'){
                    customerOrderItem.BusinessInteractionItem.action = 'DELETE';
                    customerOrderItem.BusinessInteractionItem.verb = 'DELETE';
                }else{
                    customerOrderItem.BusinessInteractionItem.action = 'ADD';
                    customerOrderItem.BusinessInteractionItem.verb = 'ADD_NEW';
                }
                */
                customerOrderItem.BusinessInteractionItem.action = 'ADD';
                customerOrderItem.BusinessInteractionItem.verb = 'ADD_NEW';

                // START Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem.ProductOffering
                customerOrderItem.BusinessInteractionItem.ProductOffering = new SubmitCustomerOrderApiTypes.ProductOffering();
                // START Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem.ProductOffering.ID
                customerOrderItem.BusinessInteractionItem.ProductOffering.ID = new SubmitCustomerOrderApiTypes.IBMTelecomRootObject();
                //PricebookEntry thePricebookEntry = getPricebokEntry(theOrderItem.PricebookEntryId);
                //if(thePricebookEntry != null && thePricebookEntry.Product2 != null){
                customerOrderItem.BusinessInteractionItem.ProductOffering.ID.ID = ''; // TODO: theOrderItem.PricebookEntry.Product2.EPC_Id__c;
                customerOrderItem.BusinessInteractionItem.ProductOffering.ID.name = theOrderItem.PricebookEntry.Product2.Name;
                // translation of the value
                String productOfferingType;
                /* TODO
                if(theOrderItem.PricebookEntry.Product2.vlocity_cmt__SpecificationType__c == 'Offer'){
                    productOfferingType = 'TYPE_PRODUCT_OFFER';
                }else{
                    productOfferingType = theOrderItem.PricebookEntry.Product2.vlocity_cmt__SpecificationType__c;
                }
                */
                productOfferingType = 'TYPE_PRODUCT_OFFER';
                customerOrderItem.BusinessInteractionItem.ProductOffering.ID.type_x = productOfferingType;
                //}
                customerOrderItem.BusinessInteractionItem.ProductOffering.ID.description = '';
                // START Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem.ProductOffering.ID.ValidFor
                customerOrderItem.BusinessInteractionItem.ProductOffering.ID.ValidFor = new SubmitCustomerOrderApiTypes.TimePeriod();
                customerOrderItem.BusinessInteractionItem.ProductOffering.ID.ValidFor.startDate = System.now();
                customerOrderItem.BusinessInteractionItem.ProductOffering.ID.ValidFor.endDate = System.now();
                // END Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem.ProductOffering.ID.ValidFor
                // END Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem.ProductOffering.ID
                customerOrderItem.BusinessInteractionItem.ProductOffering.status = 'CREATED';


                customerOrderItem.BusinessInteractionItem.ProductOffering.Product = new List<SubmitCustomerOrderApiTypes.Product>();
                customerOrderItem.BusinessInteractionItem.ProductOffering.CharacteristicSpecification = new List<SubmitCustomerOrderApiTypes.CharacteristicSpecification>();

                List<utils_Attributes.OrderItemAttribute> orderItemAttributeList;
                SubmitCustomerOrderApiTypes.CharacteristicSpecification characteristicSpecification;

                customerOrderItem.BusinessInteractionItem.ProductOffering.CharacteristicSpecification.addAll(createCharacteristicSpecificationList(theOrderItem));

                // don't send child items when deleting
                //if(customerOrderItem.BusinessInteractionItem.action != 'DELETE'){
                List<VlocityOrderItem> subOrderItemList = orderItemHierarchy.get(vlocityOrderItemId).childOrderItemList;

                // START Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem.ProductOffering.Product
                customerOrderItem.BusinessInteractionItem.ProductOffering.Product = new List<SubmitCustomerOrderApiTypes.Product>();
                SubmitCustomerOrderApiTypes.Product theProduct;
                Asset theAsset;
                if(subOrderItemList != null){
                    for(VlocityOrderItem subOrderItem: subOrderItemList){
                        // START Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem.ProductOffering.Product
                        theProduct = new SubmitCustomerOrderApiTypes.Product();
                        // START Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem.ProductOffering.Product.ID
                        theProduct.ID = new SubmitCustomerOrderApiTypes.IBMTelecomRootObject();
                        theProduct.ID.ID = '';
                        /* TODO
                        theProduct.ID.ID = subOrderItem.orderItem.PricebookEntry.Product2.EPC_Id__c;
                        */
                        theProduct.ID.name = subOrderItem.orderItem.PricebookEntry.Product2.Name;
                        theProduct.CharacteristicSpecification = new List<SubmitCustomerOrderApiTypes.CharacteristicSpecification>();
                        theProduct.CharacteristicSpecification.addAll(createCharacteristicSpecificationList(subOrderItem.orderItem));

                        // add asset
                        if(assetOrderItemMap != null && assetOrderItemMap.containsKey(theOrderItem.Id)){
                            theAsset = assetOrderItemMap.get(subOrderItem.orderItem.Id);
                            characteristicSpecification = new SubmitCustomerOrderApiTypes.CharacteristicSpecification();
                            characteristicSpecification.name = 'AssetID';
                            characteristicSpecification.description = 'Unique Asset Identifier for the instance';
                            characteristicSpecification.valueType = 'xsd:integer';
                            characteristicSpecification.Value = new SubmitCustomerOrderApiTypes.CharacteristicValue();
                            characteristicSpecification.Value.value = '';
                            /* TODO
                            characteristicSpecification.Value.value = theAsset.Asset_Number__c;
                            */
                            theProduct.CharacteristicSpecification.add(characteristicSpecification);
                        }
                        // END Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem.ProductOffering.Product.ID
                        customerOrderItem.BusinessInteractionItem.ProductOffering.Product.add(theProduct);
                    }
                }
                // add asset
                if(assetOrderItemMap != null && assetOrderItemMap.containsKey(theOrderItem.Id)){
                    theAsset = assetOrderItemMap.get(theOrderItem.Id);
                    characteristicSpecification = new SubmitCustomerOrderApiTypes.CharacteristicSpecification();
                    characteristicSpecification.name = 'AssetID';
                    characteristicSpecification.description = 'Unique Asset Identifier for the instance';
                    characteristicSpecification.valueType = 'xsd:integer';
                    characteristicSpecification.Value = new SubmitCustomerOrderApiTypes.CharacteristicValue();
                    /*
                    characteristicSpecification.Value.value = theAsset.Asset_Number__c;
                    */
                    characteristicSpecification.Value.value = '';
                    customerOrderItem.BusinessInteractionItem.ProductOffering.CharacteristicSpecification.add(characteristicSpecification);
                }
                //}
                // END Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem.ProductOffering
                // END Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem
                customerOrder.CustomerOrderItem.add(customerOrderItem);
                // END Payload.CustomerOrderItem
            }
            payload.add(customerOrder);
            // END Payload
        }

        return payload;
    }

    public override Object invoke(Object connection, Object request){
        SubmitCustomerOrderApiTypes.msg_CustomerOrder response;

        SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort submitCustomerOrderConnection = (SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort) connection;
        SubmitCustomerOrderApiTypes.msg_CustomerOrder submitCustomerOrderRequest = (SubmitCustomerOrderApiTypes.msg_CustomerOrder) request;

        Boolean processedResponse;

        try{
            response = submitCustomerOrderConnection.invoke(submitCustomerOrderRequest);
        }catch(Exception exp){
            logError(exp, connection, request, response);
            return null;
        }

        try{
            processedResponse = (Boolean)processResponse(request, response);
        }catch(Exception exp){
            logError(exp, connection, request, response);
            return null;
        }

        logInfo(connection, request, response);

        return processedResponse;
    }

    public override String invoke(String connection, String request){
        String responseStr;

        SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort submitCustomerOrderConnection;
        SubmitCustomerOrderApiTypes.msg_CustomerOrder submitCustomerOrderRequest;

        try{
            submitCustomerOrderConnection = (SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort)JSON.deserialize(connection, SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort.class);
            submitCustomerOrderRequest = (SubmitCustomerOrderApiTypes.msg_CustomerOrder)JSON.deserialize(request, SubmitCustomerOrderApiTypes.msg_CustomerOrder.class);
        }catch(System.Exception e){
            logError(e, connection, request, null);
            return '';
        }

        responseStr = JSON.serialize(invoke(submitCustomerOrderConnection, submitCustomerOrderRequest));

        return responseStr;
    }

    public override Object processResponse(Object request, Object response){
        Boolean processedResponse = true;

        // TODO: Populate the response

        return processedResponse;
    }

    public override Map<String, String> getLogValues(Object request, Object response){
        Map<String, String> logValues = new Map<String, String>();

        logValues.put('sfObjectId', '');
        logValues.put('sfObjectType', '');
        logValues.put('serviceName', '');
        logValues.put('resultCode', '');
        logValues.put('resultHeader', '');
        logValues.put('resultMessage', '');
        logValues.put('originalConnection', '');
        logValues.put('originalRequest', '');

        return logValues;
    }

    /************************************************ Utils ***********************************************************/

    public static Map<Id, Asset> getAssetMapForOrderItem(String orderId){
        Map<Id, Asset> assetOrderItemMap;
        /* TODO
        List<Asset> assetList = [select Id, vlocity_cmt__OrderProductId__c, vlocity_cmt__ProvisioningStatus__c, Asset_Number__c from Asset where vlocity_cmt__OrderProductId__r.OrderId = :orderId];

        if(assetList != null){
            assetOrderItemMap = new Map<Id, Asset>();
            for(Asset theAsset: assetList){
                assetOrderItemMap.put(theAsset.vlocity_cmt__OrderProductId__c, theAsset);
            }
        }
        */
        return assetOrderItemMap;
    }

    public static Map<Id, VlocityOrderItem> createOrderItemHierarchy(List<OrderItem> orderItemList){
        Map<Id, VlocityOrderItem> vlocityOrderItemMap = new Map<Id, VlocityOrderItem>();
        for(OrderItem orderItem: orderItemList){
            vlocityOrderItemMap.put(orderItem.Id, new VlocityOrderItem(orderItem));
        }

        VlocityOrderItem parentTemp;
        for(Id orderItemId: vlocityOrderItemMap.keySet()){
            /* TODO
            if(vlocityOrderItemMap.containsKey(vlocityOrderItemMap.get(orderItemId).orderItem.vlocity_cmt__ParentItemId__c)){
                parentTemp = vlocityOrderItemMap.get(vlocityOrderItemMap.get(orderItemId).orderItem.vlocity_cmt__ParentItemId__c);
                if(parentTemp.childOrderItemList == null){
                    parentTemp.childOrderItemList = new List<VlocityOrderItem>();
                    parentTemp.childOrderItemList.add(vlocityOrderItemMap.get(orderItemId));
                }else{
                    parentTemp.childOrderItemList.add(vlocityOrderItemMap.get(orderItemId));
                }
            }
            */
        }

        return makeItFlat(vlocityOrderItemMap);
    }

    public class VlocityOrderItem{
        public VlocityOrderItem(OrderItem theOrderItem){
            this.orderItem = theOrderItem;
        }
        public OrderItem orderItem;
        public List<VlocityOrderItem> childOrderItemList;
    }

    public static List<SubmitCustomerOrderApiTypes.CharacteristicSpecification> createCharacteristicSpecificationList(OrderItem theOrderItem){
        List<SubmitCustomerOrderApiTypes.CharacteristicSpecification> characteristicSpecificationList = new List<SubmitCustomerOrderApiTypes.CharacteristicSpecification>();
        /* TODO
        if(theOrderItem.vlocity_cmt__JSONAttribute__c != null && theOrderItem.vlocity_cmt__JSONAttribute__c != ''){
            // JSON example: '{"VLO-PRO-0004":[{"$$AttributeDefinitionStart$$":null,"objectid__c":"01t36000001TFOOAA4","attributeid__c":"a0J36000000rXplEAE","attributecategoryid__c":"a0I36000001YsHWEA0","categorycode__c":"VLO-PRO-0004","categoryname__c":"Mobile Contract","attributeuniquecode__c":"ATTRIBUTE-013","attributeconfigurable__c":true,"attributedisplaysequence__c":"1","attributefilterable__c":true,"isactive__c":true,"attributedisplayname__c":"Mobile Minutes","displaysequence__c":"12","formatmask__c":null,"hasrule__c":false,"isconfigurable__c":false,"ishidden__c":false,"valueinnumber__c":1000.0,"objecttype__c":"Product2","querycode__c":null,"isreadonly__c":true,"isquerydriven__c":false,"querylabel__c":null,"id":"a0H36000004DVEcEAO","isrequired__c":false,"rulemessage__c":null,"uidisplaytype__c":null,"value__c":"1000","valuedatatype__c":"Text","valuedescription__c":"The amount of minutes available on the tariff.","attributeRunTimeInfo":{"dataType":"Text","default":"1000"},"$$AttributeDefinitionEnd$$":null},{"$$AttributeDefinitionStart$$":null,"objectid__c":"01t36000001TFOOAA4","attributeid__c":"a0J36000000rXpqEAE","attributecategoryid__c":"a0I36000001YsHWEA0","categorycode__c":"VLO-PRO-0004","categoryname__c":"Mobile Contract","attributeuniquecode__c":"ATTRIBUTE-014","attributeconfigurable__c":true,"attributedisplaysequence__c":"2","attributefilterable__c":true,"isactive__c":true,"attributedisplayname__c":"Mobile Data","displaysequence__c":"12","formatmask__c":null,"hasrule__c":false,"isconfigurable__c":false,"ishidden__c":false,"valueinnumber__c":null,"objecttype__c":"Product2","querycode__c":null,"isreadonly__c":true,"isquerydriven__c":false,"querylabel__c":null,"id":"a0H36000004DVEaEAO","isrequired__c":false,"rulemessage__c":null,"uidisplaytype__c":null,"value__c":"1GB","valuedatatype__c":"Text","valuedescription__c":"The amount of data available on the tariff.","attributeRunTimeInfo":{"dataType":"Text","default":"1GB"},"$$AttributeDefinitionEnd$$":null},{"$$AttributeDefinitionStart$$":null,"objectid__c":"01t36000001TFOOAA4","attributeid__c":"a0J36000000rXoyEAE","attributecategoryid__c":"a0I36000001YsHWEA0","categorycode__c":"VLO-PRO-0004","categoryname__c":"Mobile Contract","attributeuniquecode__c":"ATTRIBUTE-015","attributeconfigurable__c":true,"attributedisplaysequence__c":"3","attributefilterable__c":true,"isactive__c":true,"attributedisplayname__c":"Mobile Messages","displaysequence__c":"12","formatmask__c":null,"hasrule__c":false,"isconfigurable__c":false,"ishidden__c":false,"valueinnumber__c":1000.0,"objecttype__c":"Product2","querycode__c":null,"isreadonly__c":true,"isquerydriven__c":false,"querylabel__c":null,"id":"a0H36000004DVEbEAO","isrequired__c":false,"rulemessage__c":null,"uidisplaytype__c":null,"value__c":"1000","valuedatatype__c":"Text","valuedescription__c":"The amount of messages available on the tariff.","attributeRunTimeInfo":{"dataType":"Text","default":"1000"},"$$AttributeDefinitionEnd$$":null}]}'
            List<utils_Attributes.OrderItemAttribute> orderItemAttributeList = utils_Attributes.parseOrderItemAttributes(theOrderItem.vlocity_cmt__JSONAttribute__c);
            SubmitCustomerOrderApiTypes.CharacteristicSpecification characteristicSpecification;

            // new version of JSON structure
            if(orderItemAttributeList != null){
                for(utils_Attributes.OrderItemAttribute attribute: orderItemAttributeList){
                    characteristicSpecification = new SubmitCustomerOrderApiTypes.CharacteristicSpecification();
                    characteristicSpecification.name = attribute.AttributeUniqueCode;
                    characteristicSpecification.description = attribute.Name;
                    characteristicSpecification.valueType = translateAttributeDataType(attribute.ValueDataType);
                    characteristicSpecification.Value = new SubmitCustomerOrderApiTypes.CharacteristicValue();
                    if(attribute.AttributeRunTimeInfo != null){
                        characteristicSpecification.Value.value = (String) attribute.AttributeRunTimeInfo.Value;
                        characteristicSpecification.valueType = translateAttributeDataType(attribute.AttributeRunTimeInfo.DataType);

                    }
                    characteristicSpecificationList.add(characteristicSpecification);
                }
            }
        }
        */
        return characteristicSpecificationList;
    }


    public static Map<Id, VlocityOrderItem> makeItFlat(Map<Id, VlocityOrderItem> vlocityOrderItemMap){
        Map<Id, VlocityOrderItem> flatVlocityOrderItemMap = new Map<Id, VlocityOrderItem>();

        VlocityOrderItem tempOrderItem;
        for(Id vlocityOrderItemId: vlocityOrderItemMap.keySet()){
            tempOrderItem = vlocityOrderItemMap.get(vlocityOrderItemId);
            // parent
            /* TODO
            if(tempOrderItem.orderItem.vlocity_cmt__ParentItemId__c == null){
                tempOrderItem.childOrderItemList = getArray(tempOrderItem, new List<VlocityOrderItem>(), 0);
                flatVlocityOrderItemMap.put(tempOrderItem.orderItem.Id, tempOrderItem);
            }
            */
        }
        return flatVlocityOrderItemMap;
    }
}