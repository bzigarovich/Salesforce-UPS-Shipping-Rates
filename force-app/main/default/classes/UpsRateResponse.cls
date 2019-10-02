/**
 * UPS rate request response class.
 * @author Brian Zigarovich
 */
public with sharing class UpsRateResponse {
    
    /**
     * Status inner class.
     */
    public class Status {
        public String Code;
        public String Description;
    }

    /**
     * Reference inner class.
     */
    public class Reference {
        public String CustomerContext;
        public String TransactionIdentifier;
    }

    /**
     * Response inner class.
     */
    public class Response {
        public Reference TransactionReference;
    }

    /**
     * Weight inner class.
     */
    public class Weight {
        public Status UnitOfMeasurement;
        public String Weight;
    }

    /**
     * Charge inner class.
     */
    public class Charge {
        public String CurrencyCode;
        public String MonetaryValue;
    }

    /**
     * Delivery inner class.
     */
    public class Delivery {
        public String BusinessDaysInTransit;
        public String DeliveryByTime;
    }

    /**
     * Rated package inner class.
     */
    public class RatedPackage {
        public Charge TransportationCharges;
        public Charge ServiceOptionsCharges;
        public Charge TotalCharges;
        public String Weight;
        public Weight BillingWeight;
    }

    /**
     * Shipment option inner class.
     */
    public class ShipmentOption {
        public Status Service;
        public Weight BillingWeight;
        public Charge TransportationCharges;
        public Charge ServiceOptionsCharges;
        public Charge TotalCharges;
        public Delivery GuaranteedDelivery;
        public RatedPackage RatedPackage;
    }

    /**
     * Rate response inner class.
     */
    public class RateResponse {
        public Response Response;
        public List<ShipmentOption> RatedShipment;
    }

    /**
     * Error inner class.
     */
    public class Error {
        public String code;
        public String message;
    }

    /**
     * Error response data structure.
     */
    public class ErrorResponse {
        public List<Error> errors;
    }

    /**
     * Rate response instance variable.
     */
    public RateResponse RateResponse;

    /**
     * Error response.
     */
    public ErrorResponse response;

    /**
     * Deserializes a UpsRateResponse object.
     * @param json the JSON object to deserialize
     * @return the deserialized JSON object.
     */
    public static UpsRateResponse parse(String json) {
        return (UpsRateResponse)System.JSON.deserialize(json, UpsRateResponse.class);
    }
}