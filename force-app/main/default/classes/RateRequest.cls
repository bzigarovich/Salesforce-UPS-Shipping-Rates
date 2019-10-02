/**
 * Generic rate request class for making a rate request to a
 * third party shipping service. 
 * @author Brian Zigarovich
 */
public with sharing class RateRequest {
    /**
     * Address data structure.
     */
    public class Address {
        @AuraEnabled
        public String attention;

        @AuraEnabled
        public String street;

        @AuraEnabled
        public String city;

        @AuraEnabled
        public String stateCode;

        @AuraEnabled
        public String postalCode;

        @AuraEnabled
        public String countryCode;
    }

     /**
      * Shipping package data structure.
      */
    public class PackageInfo {
        @AuraEnabled
        public Decimal weight;

        @AuraEnabled
        public String weightUnits;

        @AuraEnabled
        public Decimal length;

        @AuraEnabled
        public Decimal width;

        @AuraEnabled
        public Decimal height;

        @AuraEnabled
        public String sizeUnits;
    }

    /**
     * From address.
     */
    @AuraEnabled
    public Address fromAddress;

    /**
     * To address.
     */
    @AuraEnabled
    public Address toAddress;

    /**
     * Package information.
     */
    @AuraEnabled
    public PackageInfo shipItem;

    /**
     * Deserializes a RateRequest object.
     * @param json the JSON object to deserialize
     * @return the deserialized JSON object.
     */
    public static RateRequest parse(String json) {
        return (RateRequest)System.JSON.deserialize(json, RateRequest.class);
    }
}