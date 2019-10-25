public with sharing class CommonMatrixxApiTypes {
    public CommonMatrixxApiTypes() {

    }
    public class Header {
        public String CorrelationId_T;
        public String ActivityName_T;
        public String MsgType_T;
        public String msgName;
        public String Priority_T;
        public String Source;
        public String ActivityStatusEnum_T;
        public String ActivityStatus_T;
        public String MessageId;
        public CharacteristicSpecification[] MessageProp_T;
        public CharacteristicSpecification[] Security_T;
        public DateTime Timestamp;
        public String SecurityType_T;
        public String FailureReplytoURI_T;
        public CharacteristicSpecification[] ConsumerInfo;
        public String senderURI;
        public CharacteristicSpecification[] ProviderInfo;
        public String destinationURI;
        public String replyToURI;
        private String[] CorrelationId_T_type_info = new String[]{'CorrelationId_T','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] ActivityName_T_type_info = new String[]{'ActivityName_T','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] MsgType_T_type_info = new String[]{'MsgType_T','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] msgName_type_info = new String[]{'msgName','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] Priority_T_type_info = new String[]{'Priority_T','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] Source_type_info = new String[]{'Source','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] ActivityStatusEnum_T_type_info = new String[]{'ActivityStatusEnum_T','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] ActivityStatus_T_type_info = new String[]{'ActivityStatus_T','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] MessageId_type_info = new String[]{'MessageId','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] MessageProp_T_type_info = new String[]{'MessageProp_T','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','-1','false'};
        private String[] Security_T_type_info = new String[]{'Security_T','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','-1','false'};
        private String[] Timestamp_type_info = new String[]{'Timestamp','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] SecurityType_T_type_info = new String[]{'SecurityType_T','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] FailureReplytoURI_T_type_info = new String[]{'FailureReplytoURI_T','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] ConsumerInfo_type_info = new String[]{'ConsumerInfo','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','-1','false'};
        private String[] senderURI_type_info = new String[]{'senderURI','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] ProviderInfo_type_info = new String[]{'ProviderInfo','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','-1','false'};
        private String[] destinationURI_type_info = new String[]{'destinationURI','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] replyToURI_type_info = new String[]{'replyToURI','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common','true','false'};
        private String[] field_order_type_info = new String[]{'CorrelationId_T','ActivityName_T','MsgType_T','msgName','Priority_T','Source','ActivityStatusEnum_T','ActivityStatus_T','MessageId','MessageProp_T','Security_T','Timestamp','SecurityType_T','FailureReplytoURI_T','ConsumerInfo','senderURI','ProviderInfo','destinationURI','replyToURI'};
    }
    public class CharacteristicValue {
        public String value;
        private String[] value_type_info = new String[]{'value','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common','true','false'};
        private String[] field_order_type_info = new String[]{'value'};
    }
    public class CharacteristicSpecification {
        public String name;
        public String valueType;
        public String description;
        public CharacteristicValue Value;
        private String[] name_type_info = new String[]{'name','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','true'};
        private String[] valueType_type_info = new String[]{'valueType','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','true'};
        private String[] description_type_info = new String[]{'description','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','true'};
        private String[] Value_type_info = new String[]{'Value','http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common',null,'0','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://www.ibm.com/telecom/v8.5.0/businessobject/system/sid-v12.5/common','true','false'};
        private String[] field_order_type_info = new String[]{'name','valueType','description','Value'};
    }
}