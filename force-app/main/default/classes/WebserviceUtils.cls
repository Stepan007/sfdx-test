/**
 * Created by stepan on 20/04/17.
 */

public class WebserviceUtils {
    // action is from set = {"ADD", "DELETE"}
    public static Integer submitOrderToTelcoPack(Id orderId){
        /*
        // get the order
        List<Order> orderList = [select Id, Name, OrderNumber, PoNumber, EndDate, Order_Orchestration_Id__c, Due_Date__c, Account.Account_Number__c, (select Id, OrderItemNumber, vlocity_cmt__ProvisioningStatus__c, Description, Quantity, PricebookEntry.Product2.ProductCode, PricebookEntry.Product2.Name, PricebookEntry.Product2.Epc_ID__c, PricebookEntry.Product2.vlocity_cmt__SpecificationType__c, vlocity_cmt__LineItemNumber__c, vlocity_cmt__JSONAttribute__c, Order_Orchestration_Id__c, PricebookEntryId, vlocity_cmt__AssetId__c, PricebookEntry.Product2.Id, vlocity_cmt__ParentItemId__c from OrderItems where PricebookEntry.Product2.Id != '01t0Y000000CK0o') from Order where id = :orderId];

        // corellation ID from Custom settings
        WebService__c webServiceCustomSettings = [select Id, CorrelationID__c from WebService__c];

        // create the socket
        SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort socket = new SubmitCustomerOrderApi.SubmitCustomerOrder_WS_SubmitCustomerOrderHttpPort();
        // set the endpoint
        //OLD socket.endpoint_x = 'http://92.103.147.161:9080/AccessService-SterlingWeb/sca/SubmitCustomerOrderExport_WS';
        //socket.endpoint_x = 'http://92.103.147.161:9080/BusinessService-OrderManagementWeb/sca/SCOBizService_WS';
        //socket.endpoint_x = 'http://putsreq.com/aB1DR1SELwG4RZrJiwUm';
        socket.endpoint_x = 'http://putsreq.com/y10VKotcRX8dK8aEVlH8';

        // create the message
        SubmitCustomerOrderApiTypes.msg_CustomerOrder submitCustomerOrderMessage = new SubmitCustomerOrderApiTypes.msg_CustomerOrder();
        // populate header
        submitCustomerOrderMessage.Header = WebserviceUtils.createMatrixxHeader('SubmitCustomerOrder', (Integer)webServiceCustomSettings.CorrelationID__c);
        // populate body
        submitCustomerOrderMessage.Payload = WebserviceUtils.createSubmitCustomerOrderBody(orderList, (Integer)webServiceCustomSettings.CorrelationID__c);
        // send the message
        SubmitCustomerOrderApiTypes.msg_CustomerOrder response = socket.invoke(submitCustomerOrderMessage);

        // increase nad update Correlation ID for the next use
        webServiceCustomSettings.CorrelationID__c++;
        update webServiceCustomSettings;

        update new Order(
                Id = orderId,
                OM_Response__c = JSON.serialize(response)
        );

        if(response != null && response != null && response.Header != null && response.Header.ActivityStatus_T == 'Success'){
            return 0;
        }else{
            return -1;
        }
        */
        return 0;
    }

    public static Integer createBillingAccountInTelcoPack(Id accountId){
        /*
        // get the order
        List<Account> accountList = [select Id, Name, AccountNumber, vlocity_cmt__PremisesId__r.vlocity_cmt__PremisesIdentifier__c, BillingStreet, BillingCity, BillingPostalCode, BillingState, BillingCountry, vlocity_cmt__BillingEmailAddress__c, Phone, vlocity_cmt__PartyId__c from Account where id = :accountId];

        // corellation ID from Custom settings
        WebService__c webServiceCustomSettings = [select Id, CorrelationID__c from WebService__c];

        // create the socket
        CreateBillingAccountApi.CreateBillingAccount_WS_CreateBillingAccountHttpPort socket = new CreateBillingAccountApi.CreateBillingAccount_WS_CreateBillingAccountHttpPort();
        // set the endpoint
        //OLD socket.endpoint_x = 'http://92.103.147.161:9080/AccessService-SterlingWeb/sca/SubmitCustomerOrderExport_WS';
        socket.endpoint_x = 'http://92.103.147.161:9080/BusinessService-BillingWeb/sca/CreateBillingAccountExport_WS';
        //socket.endpoint_x = 'http://putsreq.com/aB1DR1SELwG4RZrJiwUm';

        // create the message
        CreateBillingAccountApiTypes.msg_CustomerAccount createBillingAccountMessage = new CreateBillingAccountApiTypes.msg_CustomerAccount();
        // populate header
        createBillingAccountMessage.Header = WebserviceUtils.createMatrixxHeader('CreateBillingAccount', (Integer)webServiceCustomSettings.CorrelationID__c);
        // populate body
        createBillingAccountMessage.Payload = WebserviceUtils.createCreateBillingAccountBody(accountList.get(0), (Integer)webServiceCustomSettings.CorrelationID__c);
        // send the message
        CreateBillingAccountApiTypes.msg_CustomerAccount response = socket.invoke(createBillingAccountMessage);

        // increase nad update Correlation ID for the next use
        webServiceCustomSettings.CorrelationID__c++;
        update webServiceCustomSettings;

        if(response != null && response != null && response.Header != null && response.Header.ActivityStatus_T == 'Success'){
            return 0;
        }else{
            return -1;
        }
        */
        return 0;
    }

    public static void SetAttributeOnOffer(String subscriberId, String resourceId, String attributeCategory, String attributeName, String attributeValue) {

    }

    public static CommonMatrixxApiTypes.Header createMatrixxHeader(String activityName, Integer correlationId){
        CommonMatrixxApiTypes.Header matrixxHeader = new CommonMatrixxApiTypes.Header();
        matrixxHeader.CorrelationId_T = correlationId + '';
        matrixxHeader.ActivityName_T = activityName; //'SubmitCustomerOrder' | 'SubmitBillingAccount';
        matrixxHeader.MsgType_T = 'REQUEST';
        matrixxHeader.Priority_T = '1';
        matrixxHeader.Source = 'VlocityON ';
        matrixxHeader.Timestamp = System.now();
        return matrixxHeader;
    }
    public static List<CreateBillingAccountApiTypes.CustomerAccount> createCreateBillingAccountBody(WebserviceTypes.AccountJSONParameters params){
        return new List<CreateBillingAccountApiTypes.CustomerAccount>();
    }
    public static List<CreateBillingAccountApiTypes.CustomerAccount> createCreateBillingAccountBody(Account theAccount, Integer correlationId){
        /*
        List<CreateBillingAccountApiTypes.CustomerAccount> createBillingAccountBody = new List<CreateBillingAccountApiTypes.CustomerAccount>();

        CreateBillingAccountApiTypes.CustomerAccount custAcc = new CreateBillingAccountApiTypes.CustomerAccount();
        /// CustomerAccount
        custAcc.ID = new CreateBillingAccountApiTypes.IBMTelecomRootObject();
        custAcc.ID.ID = '10001';//(math.random() * 10000).intValue() + ''; //random number for testing purposes instead of theAccount.AccountNumber;
        custAcc.accountType = '';
        custAcc.accountStatus = 'Active';
        //custAcc.PIN = 'PIN34983749837';

        // Start of PartyRole
        custAcc.CustomerAccountPartyRole = new List<CreateBillingAccountApiTypes.PartyRole>();
        CreateBillingAccountApiTypes.PartyRole prolePassPortId = new CreateBillingAccountApiTypes.PartyRole();
        CreateBillingAccountApiTypes.PartyRole prole = new CreateBillingAccountApiTypes.PartyRole();
        // Start of PassportIdentification
        prolePassPortId.ID = new CreateBillingAccountApiTypes.IBMTelecomRootObject();
        prolePassPortId.ID.ID = '';
        prolePassPortId.roleType = 'Residential';

        // Start of ContactMedium
        prole.ContactMedium = new CreateBillingAccountApiTypes.ContactMedium();
        prole.ContactMedium.ID = new CreateBillingAccountApiTypes.IBMTelecomRootObject();
        prole.ContactMedium.ID.ID = '';
        prole.ContactMedium.PostalAddress = new List<CreateBillingAccountApiTypes.PostalAddress>();
        CreateBillingAccountApiTypes.PostalAddress paddr = new CreateBillingAccountApiTypes.PostalAddress();
        // Start of PostalAddress
        paddr.ID = new CreateBillingAccountApiTypes.IBMTelecomRootObject();
        paddr.ID.ID = theAccount.vlocity_cmt__PremisesId__r.vlocity_cmt__PremisesIdentifier__c;//Account.vlocity_cmt__PremisesId__r.vlocity_cmt__PremisesIdentifier__c;
        paddr.ID.name = 'BillingAddress';
        paddr.ID.type_x = '';
        paddr.ID.description = '';
        paddr.CharacteristicSpecification = new List<CreateBillingAccountApiTypes.CharacteristicSpecification>();
        CreateBillingAccountApiTypes.CharacteristicSpecification chspec = new CreateBillingAccountApiTypes.CharacteristicSpecification();
        chspec.name = '';
        chspec.valueType = '';
        paddr.CharacteristicSpecification.add(chspec);
        paddr.addressLine1 = theAccount.BillingStreet;
        paddr.addressLine2 = '';
        paddr.addressLine3 = '';
        paddr.GeographicAddress = new CreateBillingAccountApiTypes.GeographicAddress();
        paddr.GeographicAddress.ID = new CreateBillingAccountApiTypes.IBMTelecomRootObject();
        paddr.GeographicAddress.ID.ID = '';
        paddr.GeographicAddress.UrbanPropertyAddress = new CreateBillingAccountApiTypes.UrbanPropertyAddress();
        paddr.GeographicAddress.UrbanPropertyAddress.streetNrFirst = '';
        //paddr.GeographicAddress.UrbanPropertyAddress.streetNrFirstSuffix = '';
        paddr.GeographicAddress.UrbanPropertyAddress.streetNrLast = '';
        paddr.GeographicAddress.UrbanPropertyAddress.streetName = '';
        paddr.GeographicAddress.UrbanPropertyAddress.streetType = '';
        paddr.GeographicAddress.UrbanPropertyAddress.streetSuffix = '';
        paddr.GeographicAddress.UrbanPropertyAddress.locality = theAccount.BillingCity;
        paddr.GeographicAddress.UrbanPropertyAddress.postcode = theAccount.BillingPostalCode;
        paddr.GeographicAddress.UrbanPropertyAddress.UrbanPropertySubAddress = new CreateBillingAccountApiTypes.UrbanPropertySubAddress();
        paddr.GeographicAddress.UrbanPropertyAddress.UrbanPropertySubAddress.subUnitType = '';
        paddr.GeographicAddress.UrbanPropertyAddress.UrbanPropertySubAddress.subUnitNr = '';
        paddr.GeographicAddress.UrbanPropertyAddress.UrbanPropertySubAddress.levelType = '';
        paddr.GeographicAddress.UrbanPropertyAddress.UrbanPropertySubAddress.levelNr = '';
        paddr.GeographicAddress.UrbanPropertyAddress.UrbanPropertySubAddress.buildingName = '';
        paddr.GeographicAddress.stateOrProvince = theAccount.BillingState;
        paddr.GeographicAddress.country = theAccount.BillingCountry;
        paddr.PostalAddressExtension = new CreateBillingAccountApiTypes.PostalAddressExtension();
        paddr.PostalAddressExtension.isPOBox = '';
        // END of PostalAddress
        prole.ContactMedium.eMailAddress = new List<String>();
        prole.ContactMedium.eMailAddress.add(theAccount.vlocity_cmt__BillingEmailAddress__c);
        prole.ContactMedium.TelephoneNumber = new List<CreateBillingAccountApiTypes.TelephoneNumber>();
        CreateBillingAccountApiTypes.TelephoneNumber telNo = new CreateBillingAccountApiTypes.TelephoneNumber();
        telNo.number_x = theAccount.Phone;
        telNo.type_x = 'Mobile';
        prole.ContactMedium.TelephoneNumber.add(telNo);
        prole.ContactMedium.PostalAddress.add(paddr);
        // END of ContactMedium
        prole.status = '';
        prole.validFor = new CreateBillingAccountApiTypes.TimePeriod();
        prole.validFor.startDate = System.now();
        prole.validFor.endDate = System.now().addDays(1);
        // Start of Party
        prole.Party = new CreateBillingAccountApiTypes.Party();
        prole.Party.ID = new CreateBillingAccountApiTypes.IBMTelecomRootObject();
        prole.Party.ID.ID = theAccount.vlocity_cmt__PartyId__c;
        prole.Party.languageAbility = 'English';
        prole.Party.Individual = new CreateBillingAccountApiTypes.Individual();
        prole.Party.Individual.IndividualName = new CreateBillingAccountApiTypes.IndividualName();
        prole.Party.Individual.IndividualName.formattedName = theAccount.Name;
        prole.Party.Individual.IndividualName.familyNames = new List<String>();
        prole.Party.Individual.IndividualName.familyNames.add(theAccount.Name);
        prole.Party.Individual.IndividualName.legalName = '';
        prole.Party.Individual.IndividualName.givenNames = new List<String>();
        prole.Party.Individual.IndividualName.givenNames.add(theAccount.Name);
        prole.Party.Individual.IndividualName.middleNames = new List<String>();
        prole.Party.Individual.IndividualName.middleNames.add('');
        prole.Party.Individual.IndividualName.formOfAddress = '';//theAccount.Salutation;
        prole.Party.Individual.IndividualName.familyGeneration = '';
        prole.Party.Individual.IndividualName.preferredGivenName = '';
        prole.Party.Individual.IndividualName.IndividualNameExtension =  new CreateBillingAccountApiTypes.IndividualExtension();
        prole.Party.Individual.IndividualName.IndividualNameExtension.hireDate = System.now();//Datetime.parse('2016-09-28T18:31:06.965Z');
        prole.Party.Individual.gender = '';
        prole.Party.Individual.placeOfBirth = '';
        prole.Party.Individual.nationality = '';
        prole.Party.Individual.maritalStatus = '';
        prole.Party.Individual.countryOfBirth = '';
        prole.Party.Individual.AliveDuring = new CreateBillingAccountApiTypes.TimePeriod();
        prole.Party.Individual.AliveDuring.startDate = System.now();//Datetime.parse('2004-01-01T18:31:06.965Z');
        prole.Party.Individual.AliveDuring.endDate = System.now();//Datetime.parse('2099-09-28T18:31:06.965Z');
        prole.Party.Individual.IndividualIdentification = new CreateBillingAccountApiTypes.Identification();
        prole.Party.Individual.IndividualIdentification.ID = new CreateBillingAccountApiTypes.IBMTelecomRootObject();
        prole.Party.Individual.IndividualIdentification.ID.ID = '';
        prole.Party.Individual.IndividualIdentification.ID.name = '';
        // END of Party
        // End of PartyRole

        custAcc.CustomerAccountPartyRole.add(prolePassPortId);
        custAcc.CustomerAccountPartyRole.add(prole);

        custAcc.CustomerBillSpec = new List<CreateBillingAccountApiTypes.CustomerBillSpec>();
        CreateBillingAccountApiTypes.CustomerBillSpec customerBillSpec = new CreateBillingAccountApiTypes.CustomerBillSpec();
        customerBillSpec.ID = new CreateBillingAccountApiTypes.IBMTelecomRootObject();
        customerBillSpec.ID.ID = 'UniqueBilSpecID';
        customerBillSpec.customerBillFormat = new List<CreateBillingAccountApiTypes.CustomerBillFormat>();
        CreateBillingAccountApiTypes.CustomerBillFormat customerBillFormat = new CreateBillingAccountApiTypes.CustomerBillFormat();
        customerBillFormat.ID = new CreateBillingAccountApiTypes.IBMTelecomRootObject();
        customerBillFormat.ID.ID = 'BillFormatID';
        customerBillFormat.CustomerBillPresentationMedia = new List<CreateBillingAccountApiTypes.CustomerBillPresentationMedia>();
        CreateBillingAccountApiTypes.CustomerBillPresentationMedia customerBillPresentationMedia = new CreateBillingAccountApiTypes.CustomerBillPresentationMedia();
        customerBillPresentationMedia.presentationType = 'PaperlessBilling';
        customerBillFormat.CustomerBillPresentationMedia.add(customerBillPresentationMedia);
        customerBillSpec.customerBillFormat.add(customerBillFormat);
        customerBillSpec.CustomerBillingCycle = new List<CreateBillingAccountApiTypes.CustomerBillingCycle>();
        CreateBillingAccountApiTypes.CustomerBillingCycle customerBillingCycle = new CreateBillingAccountApiTypes.CustomerBillingCycle();
        customerBillingCycle.billingDate = System.now();
        customerBillSpec.CustomerBillingCycle.add(customerBillingCycle);
        customerBillSpec.CustomerBillingCycleSpecification = new List<CreateBillingAccountApiTypes.CustomerBillingCycleSpecification>();
        CreateBillingAccountApiTypes.CustomerBillingCycleSpecification customerBillingCycleSpecification = new CreateBillingAccountApiTypes.CustomerBillingCycleSpecification();
        customerBillingCycleSpecification.BillingPeriod = new CreateBillingAccountApiTypes.BillingPeriod();
        customerBillingCycleSpecification.BillingPeriod.billingPeriodName = 'POC Bill Cycle';
        customerBillSpec.CustomerBillingCycleSpecification.add(customerBillingCycleSpecification);
        custAcc.CustomerBillSpec.add(customerBillSpec);
        createBillingAccountBody.add(custAcc);
        return createBillingAccountBody;
        */
        return new List<CreateBillingAccountApiTypes.CustomerAccount>();
    }

/******************************************************* SUBMIT CUSTOMER ORDER **************************************************/

    public static List<SubmitCustomerOrderApiTypes.CustomerOrder> createSubmitCustomerOrderBody(List<Order> orderList, Integer correlationId){
        /*

        // START Payload
        List<SubmitCustomerOrderApiTypes.CustomerOrder> submitCustomerOrderBody= new List<SubmitCustomerOrderApiTypes.CustomerOrder>();

        SubmitCustomerOrderApiTypes.CustomerOrder customerOrder;

        for(Order theOrder: orderList){
            customerOrder = new SubmitCustomerOrderApiTypes.CustomerOrder();
            // START Payload.ID
            customerOrder.Id = new SubmitCustomerOrderApiTypes.IBMTelecomRootObject();
            customerOrder.Id.ID = theOrder.Order_Orchestration_Id__c; //  + '' + correlationId
            customerOrder.Id.name = theOrder.Name;
            customerOrder.Id.type_x = '';
            customerOrder.Id.description = '';
            // START Payload.ID.ValidFor
            customerOrder.Id.ValidFor = new SubmitCustomerOrderApiTypes.TimePeriod();
            customerOrder.Id.ValidFor.startDate = System.now();
            customerOrder.Id.ValidFor.endDate = System.now();
            // END Payload.ID.ValidFor
            // END Payload.ID

            customerOrder.purchaseOrderNumber = theOrder.Order_Orchestration_Id__c; //  + '' + correlationId
            customerOrder.customerOrderType = 'ProductOrder';
            customerOrder.dueDate = theOrder.Due_Date__c;

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
            customerAccountInteractionRole1.ID.ID = theOrder.Account.Account_Number__c;
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
                // START Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem.ProductOffering
                customerOrderItem.BusinessInteractionItem.ProductOffering = new SubmitCustomerOrderApiTypes.ProductOffering();
                // START Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem.ProductOffering.ID
                customerOrderItem.BusinessInteractionItem.ProductOffering.ID = new SubmitCustomerOrderApiTypes.IBMTelecomRootObject();
                //PricebookEntry thePricebookEntry = getPricebokEntry(theOrderItem.PricebookEntryId);
                //if(thePricebookEntry != null && thePricebookEntry.Product2 != null){
                customerOrderItem.BusinessInteractionItem.ProductOffering.ID.ID = theOrderItem.PricebookEntry.Product2.EPC_Id__c;
                customerOrderItem.BusinessInteractionItem.ProductOffering.ID.name = theOrderItem.PricebookEntry.Product2.Name;
                // translation of the value
                String productOfferingType;
                if(theOrderItem.PricebookEntry.Product2.vlocity_cmt__SpecificationType__c == 'Offer'){
                    productOfferingType = 'TYPE_PRODUCT_OFFER';
                }else{
                    productOfferingType = theOrderItem.PricebookEntry.Product2.vlocity_cmt__SpecificationType__c;
                }
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
                        theProduct.ID.ID = subOrderItem.orderItem.PricebookEntry.Product2.EPC_Id__c;
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
                            characteristicSpecification.Value.value = theAsset.Asset_Number__c;
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
                    characteristicSpecification.Value.value = theAsset.Asset_Number__c;
                    customerOrderItem.BusinessInteractionItem.ProductOffering.CharacteristicSpecification.add(characteristicSpecification);
                }
                //}
                // END Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem.ProductOffering
                // END Payload.CustomerOrder.CustomerOrderItem.BusinessInteractionItem
                customerOrder.CustomerOrderItem.add(customerOrderItem);
                // END Payload.CustomerOrderItem
            }
            submitCustomerOrderBody.add(customerOrder);
            // END Payload
        }
        return submitCustomerOrderBody;
        */
        return new List<SubmitCustomerOrderApiTypes.CustomerOrder>();
    }

    public static Map<Id, Asset> getAssetMapForOrderItem(String orderId){
        /*
        Map<Id, Asset> assetOrderItemMap;

        List<Asset> assetList = [select Id, Order_Orchestration_Id__c, vlocity_cmt__OrderProductId__c, vlocity_cmt__ProvisioningStatus__c, Asset_Number__c from Asset where vlocity_cmt__OrderProductId__r.OrderId = :orderId];

        if(assetList != null){
            assetOrderItemMap = new Map<Id, Asset>();
            for(Asset theAsset: assetList){
                assetOrderItemMap.put(theAsset.vlocity_cmt__OrderProductId__c, theAsset);
            }
        }
        return assetOrderItemMap;
        */
        return new Map<Id, Asset>();
    }

    public static List<SubmitCustomerOrderApiTypes.CharacteristicSpecification> createCharacteristicSpecificationList(OrderItem theOrderItem){
        /*
        List<SubmitCustomerOrderApiTypes.CharacteristicSpecification> characteristicSpecificationList = new List<SubmitCustomerOrderApiTypes.CharacteristicSpecification>();
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
        return characteristicSpecificationList;
        */
        return new List<SubmitCustomerOrderApiTypes.CharacteristicSpecification>();
    }

    public static String translateAttributeDataType(String dataType){
        String retValue = '';

        if(dataType == 'Text'){
            retValue = 'xsd:string';
        }else if(dataType == 'Number'){
            retValue = 'xsd:integer';
        }else if(dataType == 'Checkbox'){
            retValue = 'xsd:boolean';
        }else{
            // by default
            retValue = 'xsd:string';
        }
        return retValue;
    }

    public static Map<Id, VlocityOrderItem> createOrderItemHierarchy(List<OrderItem> orderItemList){
        /*
        Map<Id, VlocityOrderItem> vlocityOrderItemMap = new Map<Id, VlocityOrderItem>();
        for(OrderItem orderItem: orderItemList){
            vlocityOrderItemMap.put(orderItem.Id, new VlocityOrderItem(orderItem));
        }

        VlocityOrderItem parentTemp;
        for(Id orderItemId: vlocityOrderItemMap.keySet()){
            if(vlocityOrderItemMap.containsKey(vlocityOrderItemMap.get(orderItemId).orderItem.vlocity_cmt__ParentItemId__c)){
                parentTemp = vlocityOrderItemMap.get(vlocityOrderItemMap.get(orderItemId).orderItem.vlocity_cmt__ParentItemId__c);
                if(parentTemp.childOrderItemList == null){
                    parentTemp.childOrderItemList = new List<VlocityOrderItem>();
                    parentTemp.childOrderItemList.add(vlocityOrderItemMap.get(orderItemId));
                }else{
                    parentTemp.childOrderItemList.add(vlocityOrderItemMap.get(orderItemId));
                }
            }
        }

        return makeItFlat(vlocityOrderItemMap);
        */
        return new Map<Id, VlocityOrderItem>();
    }

    public static Map<Id, VlocityOrderItem> makeItFlat(Map<Id, VlocityOrderItem> vlocityOrderItemMap){
        /*
        Map<Id, VlocityOrderItem> flatVlocityOrderItemMap = new Map<Id, VlocityOrderItem>();

        VlocityOrderItem tempOrderItem;
        for(Id vlocityOrderItemId: vlocityOrderItemMap.keySet()){
            tempOrderItem = vlocityOrderItemMap.get(vlocityOrderItemId);
            // parent
            if(tempOrderItem.orderItem.vlocity_cmt__ParentItemId__c == null){
                tempOrderItem.childOrderItemList = getArray(tempOrderItem, new List<VlocityOrderItem>(), 0);
                flatVlocityOrderItemMap.put(tempOrderItem.orderItem.Id, tempOrderItem);
            }
        }
        return flatVlocityOrderItemMap;
        */
        return new Map<Id, VlocityOrderItem>();
    }

    public static List<VlocityOrderItem> getArray(VlocityOrderItem originalOrderItem, List<VlocityOrderItem> resultVlocityOrderItemList, Integer level){
        /*
        if(originalOrderItem.childOrderItemList != null){
            for(VlocityOrderItem vlocityOrderItemChild: originalOrderItem.childOrderItemList){
                resultVlocityOrderItemList = getArray(vlocityOrderItemChild, resultVlocityOrderItemList, level + 1);
            }
            // filter - skip the parent and exclude products with particular specification type
            if(level != 0 && (originalOrderItem.orderItem.PricebookEntry.Product2.vlocity_cmt__SpecificationType__c != 'Product' && originalOrderItem.orderItem.PricebookEntry.Product2.vlocity_cmt__SpecificationType__c != 'Price Plan')){
                resultVlocityOrderItemList.add(originalOrderItem);
            }
            return resultVlocityOrderItemList;
        }else{
            // filter - exclude products with particular specification type
            if(originalOrderItem.orderItem.PricebookEntry.Product2.vlocity_cmt__SpecificationType__c != 'Product' && originalOrderItem.orderItem.PricebookEntry.Product2.vlocity_cmt__SpecificationType__c != 'Price Plan'){
                resultVlocityOrderItemList.add(originalOrderItem);
            }
            return resultVlocityOrderItemList;
        }
        */
        return new List<VlocityOrderItem>();

    }

    public class VlocityOrderItem{
        public VlocityOrderItem(OrderItem theOrderItem){
            this.orderItem = theOrderItem;
        }
        public OrderItem orderItem;
        public List<VlocityOrderItem> childOrderItemList;
    }
}