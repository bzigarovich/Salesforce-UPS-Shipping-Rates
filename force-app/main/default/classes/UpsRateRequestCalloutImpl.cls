/**
 * Class for making rate request callouts to UPS.
 * @author Brian Zigarovich
 */
public with sharing class UpsRateRequestCalloutImpl implements IRateRequestCallout {

    /**
     * Shipping option map.
     */
    Map<String, String> shipOptions;

    /**
     * Default constructor.
     */
    public UpsRateRequestCalloutImpl() {
        this.shipOptions = new Map<String, String>();

        // Builds the shipping option map
        for (UPS_Domestic_Codes__mdt option : [SELECT Shipping__c, MasterLabel FROM UPS_Domestic_Codes__mdt]) {
            this.shipOptions.put(option.Shipping__c, option.MasterLabel);
        }
    }

    /**
     * @override
     */
    public HttpRequest getRequest(RateRequest request) {
        HttpRequest retval = IntegrationSettings.buildRequest('callout:UpsAPI', 'RatesUPS');
        retval.setHeader('transId', IntegrationSettings.getUUID());
        retval.setBody((new UpsRateRequest(request)).serialize());
        return retval;
    }

    /**
     * @override
     */
    public List<RateInfo> processRates(HttpResponse response) {
        List<RateInfo> retval = new List<RateInfo>();

        try {
            UpsRateResponse upsRates = UpsRateResponse.parse(response.getBody());

            // Checks for successful response
            switch on response.getStatusCode() {
                when 200 {
                    // Iterates over the shipping options
                    for(UpsRateResponse.ShipmentOption option : upsRates.RateResponse.RatedShipment) {
                        retval.add(new RateInfo(shipOptions.get(option.Service.code),
                            Decimal.valueOf(option.TransportationCharges.MonetaryValue),
                            Decimal.valueOf(option.ServiceOptionsCharges.MonetaryValue),
                            Decimal.valueOf(option.TotalCharges.MonetaryValue),
                            option.TotalCharges.CurrencyCode,
                            Decimal.valueOf(option.BillingWeight.Weight),
                            Decimal.valueOf(option.RatedPackage.Weight),
                            option.BillingWeight.UnitOfMeasurement.Code));
                    }
                }
                when else {
                    throw new RateRequestException(upsRates.response.errors[0].message);
                }
            }
        } catch (JSONException e) {
            throw new RateRequestException(Label.Exception_Parse_Error, e);
        }

        return retval;
    }
}