public with sharing class utils_Attributes {

    public static List<List<OrderItemAttribute>> parseOrderItemAttributes(List<String> texts) {
        List<List<OrderItemAttribute>> attributes = new List<List<OrderItemAttribute>>();

        for (String text : texts) {
            attributes.add(parseOrderItemAttributes(text));
        }

        return attributes;
    }

    public static List<OrderItemAttribute> parseOrderItemAttributes(String text) {

        Map<String, Object> attributesProperties = (Map<String, Object>)JSON.deserializeUntyped(text);

        List<OrderItemAttribute> attributes = new List<OrderItemAttribute>();

        for (String key : attributesProperties.keySet()) {
            if (attributesProperties.get(key) instanceOf List<Object>) {
                for (Object item : (List<Object>)attributesProperties.get(key)) {
                    Map<String, Object> attributeProperties = (Map<String, Object>)item;
                    attributes.add(parseOrderItemAttributes(attributeProperties));
                }
            }
        }

        return attributes;
    }

    public static OrderItemAttribute parseOrderItemAttributes(Map<String, Object> attributeProperties) {
        OrderItemAttribute result = new OrderItemAttribute();

        result.ObjectId = utils_ParseUtils.ParseId(attributeProperties.get('objectid__c'));
        result.AttributeId = utils_ParseUtils.ParseId(attributeProperties.get('attributeid__c'));
        result.AttributeCategoryId = utils_ParseUtils.ParseId(attributeProperties.get('attributecategoryid__c'));
        result.CategoryCode = utils_ParseUtils.ParseString(attributeProperties.get('categorycode__c'));
        result.CategoryName = utils_ParseUtils.ParseString(attributeProperties.get('categoryname__c'));
        result.AttributeUniqueCode = utils_ParseUtils.ParseString(attributeProperties.get('attributeuniquecode__c'));
        result.AttributeConfigurable = utils_ParseUtils.ParseBoolean(attributeProperties.get('attributeconfigurable__c'));
        result.AttributeDisplaySequence = utils_ParseUtils.ParseInt(attributeProperties.get('attributedisplaysequence__c'));
        result.AttributeFilterable = utils_ParseUtils.ParseBoolean(attributeProperties.get('attributefilterable__c'));
        result.IsActive = utils_ParseUtils.ParseBoolean(attributeProperties.get('isactive__c'));
        result.AttributeDisplayName = utils_ParseUtils.ParseString(attributeProperties.get('attributedisplayname__c'));
        result.DisplaySequence = utils_ParseUtils.ParseInt(attributeProperties.get('displaysequence__c'));
        result.FormatMask = utils_ParseUtils.ParseString(attributeProperties.get('formatmask__c'));
        result.HasRule = utils_ParseUtils.ParseBoolean(attributeProperties.get('hasrule__c'));
        result.IsConfigurable = utils_ParseUtils.ParseBoolean(attributeProperties.get('isconfigurable__c'));
        result.IsHidden = utils_ParseUtils.ParseBoolean(attributeProperties.get('ishidden__c'));
        result.ValueInNumber = utils_ParseUtils.ParseDecimal(attributeProperties.get('valueinnumber__c'));
        result.ObjectType = utils_ParseUtils.ParseString(attributeProperties.get('objecttype__c'));
        result.QueryCode = utils_ParseUtils.ParseString(attributeProperties.get('querycode__c'));
        result.IsReadOnly = utils_ParseUtils.ParseBoolean(attributeProperties.get('isreadonly__c'));
        result.IsQueryDriven = utils_ParseUtils.ParseBoolean(attributeProperties.get('isquerydriven__c'));
        result.QueryLabel = utils_ParseUtils.ParseString(attributeProperties.get('querylabel__c'));
        result.Id = utils_ParseUtils.ParseId(attributeProperties.get('id'));
        result.IsRequired = utils_ParseUtils.ParseBoolean(attributeProperties.get('isrequired__c'));
        result.RuleMessage = utils_ParseUtils.ParseString(attributeProperties.get('rulemessage__c'));
        result.UIDisplayType = utils_ParseUtils.ParseString(attributeProperties.get('uidisplaytype__c'));
        result.Value = utils_ParseUtils.ParseString(attributeProperties.get('value__c'));
        result.ValueDataType = utils_ParseUtils.ParseString(attributeProperties.get('valuedatatype__c'));
        result.ValueDescription = utils_ParseUtils.ParseString(attributeProperties.get('valuedescription__c'));

        if (attributeProperties.containsKey('attributeRunTimeInfo')) {
            Map<String, Object> info = (Map<String, Object>)attributeProperties.get('attributeRunTimeInfo');

            result.AttributeRunTimeInfo = new AttributeRunTimeInformation();

            result.AttributeRunTimeInfo.DataType = utils_ParseUtils.ParseString(info.get('dataType'));
            result.AttributeRunTimeInfo.DefaultValue = utils_ParseUtils.ParseString(info.get('default'));
            result.AttributeRunTimeInfo.Value = utils_ParseUtils.ParseString(info.get('value'));
        }

        result.Name = utils_ParseUtils.ParseString(attributeProperties.get('Name'));
        result.Code = utils_ParseUtils.ParseString(attributeProperties.get('Code'));
        result.Filterable = utils_ParseUtils.ParseBoolean(attributeProperties.get('Filterable'));
        result.SegmentValue = utils_ParseUtils.ParseString(attributeProperties.get('SegmentValue'));
        result.HashKey = utils_ParseUtils.ParseString(attributeProperties.get('$$hashKey'));

        return result;
    }

    public static String createOrderItemAttributes(List<OrderItemAttribute> orderItemAttributeList){
        String jsonString = '';
        for(OrderItemAttribute orderItemAttribute: orderItemAttributeList){
            if(jsonString != ''){
                jsonString += ',';
            }
            jsonString += createOrderItemAttribute(orderItemAttribute);
        }
        jsonString =  '{"MISC":[' + jsonString + ']}';
        return jsonString;
    }

    public static String createOrderItemAttribute(OrderItemAttribute orderItemAttribute){
        String jsonString = '';
        jsonString += '{"$$AttributeDefinitionStart$$":null';
        jsonString += ',"objectid__c":"' + orderItemAttribute.ObjectId + '"';
        jsonString += ',"attributeid__c":"' + orderItemAttribute.AttributeId + '"';
        jsonString += ',"categorycode__c":"' + orderItemAttribute.CategoryCode + '"';
        jsonString += ',"categoryname__c":"' + orderItemAttribute.CategoryName + '"';
        jsonString += ',"attributeuniquecode__c":"' + orderItemAttribute.AttributeUniqueCode + '"';
        jsonString += ',"attributeconfigurable__c":"' + orderItemAttribute.AttributeConfigurable + '"';
        jsonString += ',"attributedisplaysequence__c":"' + orderItemAttribute.AttributeDisplaySequence + '"';
        jsonString += ',"attributefilterable__c":"' + orderItemAttribute.AttributeFilterable + '"';
        jsonString += ',"isactive__c":"' + orderItemAttribute.IsActive + '"';
        jsonString += ',"attributedisplayname__c":"' + orderItemAttribute.ObjectId + '"';
        jsonString += ',"displaysequence__c":"' + orderItemAttribute.DisplaySequence + '"';
        jsonString += ',"formatmask__c":"' + orderItemAttribute.FormatMask + '"';
        jsonString += ',"hasrule__c":"' + orderItemAttribute.HasRule + '"';
        jsonString += ',"isconfigurable__c":"' + orderItemAttribute.IsConfigurable + '"';
        jsonString += ',"ishidden__c":"' + orderItemAttribute.IsHidden + '"';
        jsonString += ',"valueinnumber__c":"' + orderItemAttribute.ValueInNumber + '"';
        jsonString += ',"objecttype__c":"' + orderItemAttribute.ObjectType + '"';
        jsonString += ',"querycode__c":"' + orderItemAttribute.QueryCode + '"';
        jsonString += ',"isreadonly__c":"' + orderItemAttribute.IsReadOnly + '"';
        jsonString += ',"isquerydriven__c":"' + orderItemAttribute.IsQueryDriven + '"';
        jsonString += ',"querylabel__c":"' + orderItemAttribute.QueryLabel + '"';
        jsonString += ',"id":"' + orderItemAttribute.Id + '"';
        jsonString += ',"isrequired__c":"' + orderItemAttribute.IsRequired + '"';
        jsonString += ',"rulemessage__c":"' + orderItemAttribute.RuleMessage + '"';
        jsonString += ',"uidisplaytype__c":"' + orderItemAttribute.UIDisplayType + '"';
        jsonString += ',"value__c":"' + orderItemAttribute.Value + '"';
        jsonString += ',"valuedatatype__c":"' + orderItemAttribute.ValueDataType + '"';
        jsonString += ',"valuedescription__c":"' + orderItemAttribute.ValueDescription + '"';
        if(orderItemAttribute.AttributeRunTimeInfo != null){
            jsonString += ',"attributeRunTimeInfo":{';
            jsonString += '"dataType":"' + orderItemAttribute.AttributeRunTimeInfo.DataType + '"';
            jsonString += ',"default":"' + orderItemAttribute.AttributeRunTimeInfo.DefaultValue + '"';
            jsonString += ',"value":"' + orderItemAttribute.AttributeRunTimeInfo.Value + '"';
            jsonString += '}';
        }
        jsonString += ',"Name":"' + orderItemAttribute.Name + '"';
        jsonString += ',"Code":"' + orderItemAttribute.Code + '"';
        jsonString += ',"Filterable":"' + orderItemAttribute.Filterable + '"';
        jsonString += ',"SegmentValue":"' + orderItemAttribute.SegmentValue + '"';
        jsonString += ',"$$hashKey":"' + orderItemAttribute.HashKey + '"';
        jsonString += ',"$$AttributeDefinitionEnd$$":null}';
        return jsonString;
    }

    public class OrderItemAttribute {

        //"$$AttributeDefinitionStart$$":null,
        public String ProductCode {get;set;}
        public Id ObjectId {get;set;}
        public Id AttributeId {get;set;}
        public Id AttributeCategoryId {get;set;}
        public String CategoryCode {get;set;}
        public String CategoryName {get;set;}
        public String AttributeUniqueCode {get;set;}
        public Boolean AttributeConfigurable {get;set;}
        public Integer AttributeDisplaySequence {get;set;}
        public Boolean AttributeFilterable {get;set;}
        public Boolean IsActive {get;set;}
        public String AttributeDisplayName {get;set;}
        public Integer DisplaySequence {get;set;}
        public String FormatMask {get;set;}
        public Boolean HasRule {get;set;}
        public Boolean IsConfigurable {get;set;}
        public Boolean IsHidden {get;set;}
        public Decimal ValueInNumber {get;set;}
        public String ObjectType {get;set;}
        public String QueryCode {get;set;}
        public Boolean IsReadOnly {get;set;}
        public Boolean IsQueryDriven {get;set;}
        public String QueryLabel {get;set;}
        public Id Id {get;set;}
        public Boolean IsRequired {get;set;}
        public String RuleMessage {get;set;}
        public String UIDisplayType {get;set;}
        public String Value {get;set;}
        public String ValueDataType {get;set;}
        public String ValueDescription {get;set;}
        public AttributeRunTimeInformation AttributeRunTimeInfo {get;set;}
        //"$$AttributeDefinitionEnd$$":null,
        public String Name {get;set;}
        public String Code {get;set;}
        public Boolean Filterable {get;set;}
        public String SegmentValue {get;set;}
        public String HashKey {get;set;}

    }

    public class AttributeRunTimeInformation {
        public String DataType {get;set;}
        public String DefaultValue {get;set;}
        public Object Value {get;set;}
    }

}