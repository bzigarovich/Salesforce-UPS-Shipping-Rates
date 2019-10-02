/**
 * UPS rate request data structure.
 * @author Brian Zigarovich
 */
public with sharing class UpsRateRequest {
    /**
     * Unit inner class.
     */
    @TestVisible
    class Unit {
        public String Code;

        public Unit(String code) {
            this.Code = code;
        }
    }

    /**
     * Package weight inner class.
     */
    @TestVisible
    class PackageWeight {
        public Unit UnitOfMeasurement;
        public String Weight;

        public PackageWeight(String weight, String unit) {
            this.Weight = weight;
            this.UnitOfMeasurement = new Unit(unit);
        }
    }

    /**
     * Dimensions inner class.
     */
    @TestVisible
    class Dimensions {
        public Unit UnitOfMeasurement;
        public String Length;
        public String Width;
        public String Height;

        public Dimensions(String length, String width, String height, String unit) {
            this.Length = length;
            this.Width = width;
            this.height = height;
            this.UnitOfMeasurement = new Unit(unit);
        }
    }

    /**
     * Package inner class.
     */
    @TestVisible
    class Package2 {
        public Unit PackagingType;
        public Dimensions Dimensions;
        public PackageWeight PackageWeight;

        public Package2(RateRequest.PackageInfo pi, String packageType) {
            this.Dimensions = new Dimensions(String.valueOf(pi.length), String.valueOf(pi.width), String.valueOf(pi.height), pi.sizeUnits);
            this.PackageWeight = new PackageWeight(String.valueOf(pi.weight), pi.weightUnits);
            this.PackagingType = new Unit(packageType);
        }
    }

    /**
     * Address inner class.
     */
    @TestVisible
    class Address {
        public String AddressLine;
        public String City;
        public String StateProvinceCode;
        public String PostalCode;
        public String CountryCode;

        public Address(String street, String city, String stateCode, String postalCode, String countryCode) {
            this.AddressLine = street;
            this.City = city;
            this.StateProvinceCode = stateCode;
            this.PostalCode = postalCode;
            this.CountryCode = countryCode;
        }
    }

    /**
     * Address information inner class.
     */
    @TestVisible
    class AddressInfo {
        public String Name;
        public Address Address;

        public AddressInfo(RateRequest.Address addr) {
            this.Name = addr.attention;
            this.Address = new Address(addr.street, addr.city, addr.stateCode, addr.postalCode, addr.countryCode);
        }
    }

    /**
     * The package information.
     */
    @TestVisible
    protected Package2 p;

    /**
     * The shipper information.
     */
    @TestVisible
    protected AddressInfo shipFrom;

    /**
     * The recipient information.
     */
    @TestVisible
    protected AddressInfo shipTo;


    /**
     * Constructor that maps RateRequest to UpsRateRequest.
     * @param request the generic rate request object
     */
    public UpsRateRequest(RateRequest request) {
        this.p = new Package2(request.shipItem, '02');
        this.shipFrom = new AddressInfo(request.fromAddress);
        this.shipTo = new AddressInfo(request.toAddress);
    }

    /**
     * Default constructor.
     */
    public UpsRateRequest() {
        this.p = null;
        this.shipFrom = null;
        this.shipTo = null;
    }

    /**
     * @return the serialized request.
     */
    public String serialize() {
        Map<String, Object> shipment = new Map<String, Object>();
        shipment.put('Shipper', this.shipFrom);
        shipment.put('ShipTo', this.shipTo);
        shipment.put('Package', this.p);

        Map<String, Object> rateRequest = new Map<String, Object>();
        rateRequest.put('Shipment', shipment);

        Map<String, Object> request = new Map<String, Object>();
        request.put('RateRequest', rateRequest);

        return JSON.serialize(request);
    }

    /**
     * Deserializes a UpsRateRequest object.
     * @param json the JSON object to deserialize
     * @return the deserialized JSON object.
     */
    public static UpsRateRequest parse(String json) {
        Map<String, Object> request = (Map<String, Object>)System.JSON.deserializeUntyped(json);
        Map<String, Object> rateRequest = (Map<String, Object>)request.get('RateRequest');
        Map<String, Object> shipment = (Map<String, Object>)rateRequest.get('Shipment');

        UpsRateRequest retval = new UpsRateRequest();
        retval.p = (Package2)System.JSON.deserialize(System.JSON.serialize(shipment.get('Package')), Package2.class);
        retval.shipFrom = (AddressInfo)System.JSON.deserialize(System.JSON.serialize(shipment.get('Shipper')), AddressInfo.class);
        retval.shipTo = (AddressInfo)System.JSON.deserialize(System.JSON.serialize(shipment.get('ShipTo')), AddressInfo.class);

        return retval;
    }
}