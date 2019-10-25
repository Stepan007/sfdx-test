global class UpdateProductPriceApiTypes {
    global class IBMOMExport {
        webservice ProductOfferingSpecification[] productOfferingSpecifications;
        webservice ProductSpecification[] productSpecifications;
        webservice SpecificationVersion specificationVersion;
    }
    global class Value_CRM {
        webservice String valueGeneratorName;
    }
    global class Address {
        webservice String apartmentNumber;
        webservice String city;
        webservice String country;
        webservice String locality;
        webservice AddressLocalization localization;
        webservice String postCode;
        webservice String postalAddressCode;
        webservice String stateOrProvince;
        webservice String streetName;
        webservice String streetNumberFirst;
        webservice String streetNumberLast;
    }
    global class ProductOfferingPricePlanRelationshipSpecification {
        webservice String contribution;
        webservice PricePlanSpecification pricePlan;
    }
    global class RelationshipSpecification {
        webservice Integer maxMultiplicity;
        webservice Integer minMultiplicity;
        webservice Specification[] relatedSpecifications;
    }
    global class Condition_Operator {
        webservice String type_x;
    }
    global class TaxRateClass {
    }
    global class AllowanceSpecification {
        webservice Decimal[] alerts;
        webservice Boolean flatRate;
        webservice ApplicabilitySpecification overuse;
        webservice AllowancePeriodicity periodicity;
        webservice AllowanceGroupRelationshipSpecification referencedAllowanceGroup;
        webservice RolloverSpecification rolloverSpecification;
        webservice SpendingUnit spendingUnits;
        webservice Boolean totalAllowanceEditable;
        webservice Money totalFinancial;
        webservice Integer totalSpendingUnits;
    }
    global class SecurityRule {
        webservice AllowanceGroupSpecification[] allowanceGroupAccess;
        webservice Boolean cascadeDown;
        webservice ConditionExpression conditionExpression;
        webservice Boolean fullRights;
        webservice PriceItemSpecification[] priceItemAccess;
    }
    global class Value_Fixed {
        webservice Decimal decimalValue;
        webservice Integer integerValue;
    }
    global class AddressLocalization {
        webservice Localization[] localizedCityName;
        webservice Localization[] localizedStateOrProvinceName;
        webservice Localization[] localizedStreetName;
    }
    global class MarketSegment {
    }
    global class AllowanceGroupRelationshipSpecification {
        webservice AllowanceGroupSpecification group_x;
        webservice Money price;
        webservice Integer spendingUnitsForPrice;
    }
    global class ResourceReservationType {
    }
    global class CompatibilityRule {
        webservice ProductOfferingSpecification[] compatibleOfferings;
        webservice ConditionExpression conditionExpression;
        webservice ProductOfferingSpecification[] incompatibleOfferings;
    }
    global class PeriodicityType {
    }
    global class ResourceFacingServiceSpecification {
    }
    global class AllowanceGroupSpecification {
    }
    global class CharacteristicSpecification {
        webservice CharacteristicValue[] allowedValues;
        webservice Boolean commercial;
        webservice CharacteristicValue defaultValue;
        webservice Boolean editable;
        webservice Boolean mandatory;
        webservice Integer maxMultiplicity;
        webservice Integer maxSize;
        webservice CharacteristicValue maxValue;
        webservice Integer minMultiplicity;
        webservice CharacteristicValue minValue;
        webservice Boolean printable;
        webservice Integer scale;
        webservice String valueType;
        webservice Boolean visible;
    }
    global class EligibilityRule {
        webservice ConditionExpression conditionExpression;
        webservice CustomerSegment[] customerSegments;
        webservice MarketSegment[] marketSegments;
        webservice SellingChannel[] sellingChannels;
    }
    global class ProductOfferingRelationshipSpecification {
        webservice Boolean customerAssetReuse;
        webservice String inclusivityType;
        webservice Boolean isAccountOwner;
        webservice ProductOfferingPricePlanRelationshipSpecification[] relatedPricePlans;
        webservice SecurityRule[] securityRules;
    }
    global class AccountingSchemeSpecification {
        webservice AccountingItemSpecification[] items;
    }
    global class SpecificationVersion {
        webservice StatusHistory[] history;
        webservice String readableVersion;
        webservice String status;
    }
    global class Condition_Bracket {
        webservice String type_x;
    }
    global class ProductOfferingSpecification {
        webservice CustomerAccountType accountType;
        webservice Boolean activation;
        webservice Boolean addon;
        webservice AvailabilityRule[] availabilityRules;
        webservice Category[] categories;
        webservice Boolean commercial;
        webservice CompatibilityRule[] compatibilityRules;
        webservice Boolean complex;
        webservice EligibilityRule[] eligibilityRules;
        webservice PaymentMethod[] paymentMethods;
        webservice PricePlanSpecification[] pricePlanSpecifications;
        webservice ProductSpecification productSpecification;
        webservice Boolean shareable;
    }
    global class TimePeriod {
        webservice String day;
        webservice Integer from24Hour;
        webservice Integer to24Hour;
    }
    global class Characteristic {
        webservice CharacteristicSpecification specification;
        webservice CharacteristicValue value;
    }
    global class dummy_element {
        webservice String inputParam;
    }
    global class ApplicabilityRule {
        webservice ConditionExpression conditionExpression;
        webservice Country[] countries;
        webservice Location[] locations;
        webservice Boolean outsideNetwork;
        webservice String[] phoneNumbers;
        webservice Boolean roamingOrInternational;
        webservice TimePeriod[] timePeriods;
    }
    global class Country {
    }
    global class PaymentMethod {
    }
    global class DiscountSpecification {
        webservice Decimal discount;
    }
    global class CustomerFacingServiceSpecification {
    }
    global class AccountingItemSpecification {
        webservice Decimal amountPercentage;
        webservice String creditAccount;
        webservice String debitAccount;
        webservice Money fixedAmount;
        webservice Money offsetAmount;
        webservice String offsetDirection;
        webservice String revenueRecognition;
    }
    global class CustomerAccountType {
    }
    global class SpendingLimitSpecification {
        webservice Boolean limitEditable;
        webservice SpendingLimitRule rule;
    }
    global class ServiceSpecification {
    }
    global class Value_Bracket {
        webservice String type_x;
    }
    global class Category {
        webservice Category[] subcategories;
    }
    global class AllowancePeriodicity {
        webservice Integer periodicityUnits;
        webservice PeriodicityType perioditicy;
        webservice Boolean recurring;
        webservice Integer totalCycles;
    }
    global class PeriodRule {
        webservice TimeMark endMark;
        webservice String endOffsetDirection;
        webservice String endOffsetUnitType;
        webservice Long endOffsetUnits;
        webservice TimeMark startMark;
        webservice String startOffsetDirection;
        webservice String startOffsetUnitType;
        webservice Long startOffsetUnits;
    }
    global class BillingCycleSpecification {
        webservice Boolean invoice;
        webservice PeriodicityType periodicity;
        webservice Integer periodicityUnits;
        webservice Boolean recurring;
        webservice Integer totalCycles;
    }
    global class EntityContentResource {
        webservice Long id;
        webservice String key;
        webservice String mimeType;
        webservice String type_x;
        webservice String value;
    }
    global class ApplicabilitySpecification {
        webservice Boolean applicabilityEditable;
        webservice Boolean overuseAllowed;
        webservice ApplicabilityRule rule;
    }
    global class RolloverSpecification {
        webservice PeriodicityType periodicity;
        webservice Integer periodicityUnits;
    }
    global class PriceItemSpecification {
        webservice ApplicabilitySpecification applicability;
        webservice Integer maxMultiplicity;
        webservice Integer minMultiplicity;
        webservice PriceItemSpecification[] referencedPriceItems;
        webservice SingleviewDetails singleViewDetails;
        webservice TaxRateClass taxClass;
        webservice Boolean useForContractRenew;
        webservice ValueExpression valueExpression;
    }
    global class LogicalResourceSpecification {
    }
    global class PhysicalResourceSpecification {
    }
    global class Money {
        webservice Decimal amount;
        webservice String currency_x;
    }
    global class ConditionExpression {
        webservice ConditionExpressionItem[] items;
    }
    global class SellingChannel {
    }
    global class Value_Characteristic {
        webservice CharacteristicSpecification characteristicSpecification;
    }
    global class SpendingLimitRule {
        webservice Decimal[] alerts;
        webservice ApplicabilityRule applicability;
        webservice Money limit_x;
    }
    global class Localization {
        webservice Long id;
        webservice String locale;
        webservice String localizedValue;
    }
    global class SupplierPartner {
        webservice Long id;
        webservice String name;
        webservice String supplierId;
        webservice String taxNumber;
        webservice String vatId;
    }
    global class TimeMark {
    }
    global class Condition {
        webservice String conditionOperator;
        webservice ValueExpression leftValue;
        webservice ValueExpression rightValue;
    }
    global class CustomerSegment {
        webservice MarketSegment[] marketSegments;
    }
    global class PricePlanSpecification {
        webservice AllowanceGroupSpecification[] allowanceGroups;
        webservice Characteristic[] characteristics;
        webservice EligibilityRule[] eligibilityRules;
        webservice PriceItemSpecification[] items;
        webservice PeriodRule periodRule;
    }
    global class ConditionExpressionItem {
        webservice Integer sequence;
    }
    global class Specification {
        webservice CharacteristicGroupSpecification[] characteristicGroupSpecifications;
        webservice CharacteristicSpecification[] characteristicSpecifications;
        webservice StatusHistory[] history;
        webservice RelationshipSpecification[] referencedSpecifications;
        webservice String status;
        webservice Boolean storeInventory;
    }
    global class GenericRelationshipSpecification {
    }
    global class ResourceSpecification {
        webservice ResourceReservationType reservationType;
    }
    global class StatusHistory {
        webservice Long id;
        webservice String newStatus;
        webservice String oldStatus;
        webservice String reason;
        webservice DateTime timestamp;
        webservice String user_x;
    }
    global class SingleviewExport {
        webservice ProductOfferingSpecification[] productOfferingSpecifications;
        webservice SpecificationVersion specificationVersion;
    }
    global class ValueExpressionItem {
        webservice Integer sequence;
    }
    global class ProductSpecification {
    }
    global class ChargeSpecification {
        webservice Money amount;
        webservice Boolean amountEditable;
        webservice BillingCycleSpecification billingCycle;
        webservice ChargeType chargeType;
        webservice SpendingLimitSpecification spendingLimit;
        webservice SpendingUnit spendingUnits;
    }
    global class Value_Operator {
        webservice String type_x;
    }
    global class EntitySpecification {
        webservice String catalogId;
        webservice EntityContentResource[] contentResources;
        webservice String description;
        webservice String externalId;
        webservice Long id;
        webservice Localization[] localizedDescriptions;
        webservice Localization[] localizedNames;
        webservice String name;
        webservice String refId;
        webservice String type_x;
        webservice Date validFrom;
        webservice Date validTo;
        webservice SpecificationVersion version;
    }
    global class VLocityExport {
        webservice ProductOfferingSpecification[] productOfferingSpecifications;
        webservice SpecificationVersion specificationVersion;
    }
    global class CharacteristicGroupSpecification {
        webservice CharacteristicSpecification[] characteristicSpecifications;
        webservice Integer maxMultiplicity;
        webservice Integer minMultiplicity;
    }
    global class ChargeType {
    }
    global class ValueExpression {
        webservice ValueExpressionItem[] items;
    }
    global class CharacteristicValue {
        webservice String value;
        webservice String valueType;
    }
    global class SingleviewDetails {
        webservice AccountingSchemeSpecification[] accountingSchemes;
    }
    global class AvailabilityRule {
        webservice ConditionExpression conditionExpression;
        webservice Location[] locations;
    }
    global class SpendingUnit {
    }
    global class Location {
        webservice Address address;
        webservice SupplierPartner supplierPartner;
    }
}