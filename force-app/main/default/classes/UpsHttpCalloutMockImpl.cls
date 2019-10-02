/**
 * UPS shipping rates mock callout interface.
 * @author Brian Zigarovich
 */
@isTest
global class UpsHttpCalloutMockImpl implements HttpCalloutMock {
    
    /**
     * @override
     */
    global HttpResponse respond(HttpRequest req) {
        // Checks the method and endpoint
        System.assertEquals('callout:UpsAPI/ship/v1/rating/Shop', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());

        // Deserializes the request
        UpsRateRequest request = UpsRateRequest.parse(req.getBody());
        
        // Build the response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');

        // Checks the destination state
        switch on request.shipTo.Address.StateProvinceCode {
            when 'GA' {
                res.setStatusCode(200);
                res.setBody('{"RateResponse":{"Response":{"ResponseStatus":{"Code":"1", "Description":"Success"}, "Alert":[{"Code":"110971", "Description":"Your invoice may vary from the displayed reference rates"}, {"Code":"110920", "Description":"Ship To Address Classification is changed from Commercial to Residential"}], "TransactionReference":{"CustomerContext":"Salesforce", "TransactionIdentifier":"0xwsst261b25bW7d81c7Sd"}}, "RatedShipment":[{"Service":{"Code":"03", "Description":""}, "RatedShipmentAlert":[{"Code":"110971", "Description":"Your invoice may vary from the displayed reference rates"}, {"Code":"110920", "Description":"Ship To Address Classification is changed from Commercial to Residential"}], "BillingWeight":{"UnitOfMeasurement":{"Code":"LBS", "Description":"Pounds"}, "Weight":"18.0"}, "TransportationCharges":{"CurrencyCode":"USD", "MonetaryValue":"19.38"}, "ServiceOptionsCharges":{"CurrencyCode":"USD", "MonetaryValue":"0.00"}, "TotalCharges":{"CurrencyCode":"USD", "MonetaryValue":"19.38"}, "RatedPackage":{"TransportationCharges":{"CurrencyCode":"USD", "MonetaryValue":"19.38"}, "ServiceOptionsCharges":{"CurrencyCode":"USD", "MonetaryValue":"0.00"}, "TotalCharges":{"CurrencyCode":"USD", "MonetaryValue":"19.38"}, "Weight":"12.4", "BillingWeight":{"UnitOfMeasurement":{"Code":"LBS", "Description":"Pounds"}, "Weight":"18.0"}}}, {"Service":{"Code":"12", "Description":""}, "RatedShipmentAlert":[{"Code":"110971", "Description":"Your invoice may vary from the displayed reference rates"}, {"Code":"110920", "Description":"Ship To Address Classification is changed from Commercial to Residential"}], "BillingWeight":{"UnitOfMeasurement":{"Code":"LBS", "Description":"Pounds"}, "Weight":"18.0"}, "TransportationCharges":{"CurrencyCode":"USD", "MonetaryValue":"45.56"}, "ServiceOptionsCharges":{"CurrencyCode":"USD", "MonetaryValue":"0.00"}, "TotalCharges":{"CurrencyCode":"USD", "MonetaryValue":"45.56"}, "GuaranteedDelivery":{"BusinessDaysInTransit":"3"}, "RatedPackage":{"TransportationCharges":{"CurrencyCode":"USD", "MonetaryValue":"45.56"}, "ServiceOptionsCharges":{"CurrencyCode":"USD", "MonetaryValue":"0.00"}, "TotalCharges":{"CurrencyCode":"USD", "MonetaryValue":"45.56"}, "Weight":"12.4", "BillingWeight":{"UnitOfMeasurement":{"Code":"LBS", "Description":"Pounds"}, "Weight":"18.0"}}}, {"Service":{"Code":"02", "Description":""}, "RatedShipmentAlert":[{"Code":"110971", "Description":"Your invoice may vary from the displayed reference rates"}, {"Code":"110920", "Description":"Ship To Address Classification is changed from Commercial to Residential"}], "BillingWeight":{"UnitOfMeasurement":{"Code":"LBS", "Description":"Pounds"}, "Weight":"18.0"}, "TransportationCharges":{"CurrencyCode":"USD", "MonetaryValue":"64.02"}, "ServiceOptionsCharges":{"CurrencyCode":"USD", "MonetaryValue":"0.00"}, "TotalCharges":{"CurrencyCode":"USD", "MonetaryValue":"64.02"}, "GuaranteedDelivery":{"BusinessDaysInTransit":"2"}, "RatedPackage":{"TransportationCharges":{"CurrencyCode":"USD", "MonetaryValue":"64.02"}, "ServiceOptionsCharges":{"CurrencyCode":"USD", "MonetaryValue":"0.00"}, "TotalCharges":{"CurrencyCode":"USD", "MonetaryValue":"64.02"}, "Weight":"12.4", "BillingWeight":{"UnitOfMeasurement":{"Code":"LBS", "Description":"Pounds"}, "Weight":"18.0"}}}, {"Service":{"Code":"13", "Description":""}, "RatedShipmentAlert":[{"Code":"110971", "Description":"Your invoice may vary from the displayed reference rates"}, {"Code":"110920", "Description":"Ship To Address Classification is changed from Commercial to Residential"}], "BillingWeight":{"UnitOfMeasurement":{"Code":"LBS", "Description":"Pounds"}, "Weight":"18.0"}, "TransportationCharges":{"CurrencyCode":"USD", "MonetaryValue":"162.57"}, "ServiceOptionsCharges":{"CurrencyCode":"USD", "MonetaryValue":"0.00"}, "TotalCharges":{"CurrencyCode":"USD", "MonetaryValue":"162.57"}, "GuaranteedDelivery":{"BusinessDaysInTransit":"1"}, "RatedPackage":{"TransportationCharges":{"CurrencyCode":"USD", "MonetaryValue":"162.57"}, "ServiceOptionsCharges":{"CurrencyCode":"USD", "MonetaryValue":"0.00"}, "TotalCharges":{"CurrencyCode":"USD", "MonetaryValue":"162.57"}, "Weight":"12.4", "BillingWeight":{"UnitOfMeasurement":{"Code":"LBS", "Description":"Pounds"}, "Weight":"18.0"}}}, {"Service":{"Code":"14", "Description":""}, "RatedShipmentAlert":[{"Code":"110971", "Description":"Your invoice may vary from the displayed reference rates"}, {"Code":"110920", "Description":"Ship To Address Classification is changed from Commercial to Residential"}], "BillingWeight":{"UnitOfMeasurement":{"Code":"LBS", "Description":"Pounds"}, "Weight":"18.0"}, "TransportationCharges":{"CurrencyCode":"USD", "MonetaryValue":"202.90"}, "ServiceOptionsCharges":{"CurrencyCode":"USD", "MonetaryValue":"0.00"}, "TotalCharges":{"CurrencyCode":"USD", "MonetaryValue":"202.90"}, "GuaranteedDelivery":{"BusinessDaysInTransit":"1", "DeliveryByTime":"8:30 A.M."}, "RatedPackage":{"TransportationCharges":{"CurrencyCode":"USD", "MonetaryValue":"202.90"}, "ServiceOptionsCharges":{"CurrencyCode":"USD", "MonetaryValue":"0.00"}, "TotalCharges":{"CurrencyCode":"USD", "MonetaryValue":"202.90"}, "Weight":"12.4", "BillingWeight":{"UnitOfMeasurement":{"Code":"LBS", "Description":"Pounds"}, "Weight":"18.0"}}}, {"Service":{"Code":"01", "Description":""}, "RatedShipmentAlert":[{"Code":"110971", "Description":"Your invoice may vary from the displayed reference rates"}, {"Code":"110920", "Description":"Ship To Address Classification is changed from Commercial to Residential"}], "BillingWeight":{"UnitOfMeasurement":{"Code":"LBS", "Description":"Pounds"}, "Weight":"18.0"}, "TransportationCharges":{"CurrencyCode":"USD", "MonetaryValue":"170.58"}, "ServiceOptionsCharges":{"CurrencyCode":"USD", "MonetaryValue":"0.00"}, "TotalCharges":{"CurrencyCode":"USD", "MonetaryValue":"170.58"}, "GuaranteedDelivery":{"BusinessDaysInTransit":"1", "DeliveryByTime":"10:30 A.M."}, "RatedPackage":{"TransportationCharges":{"CurrencyCode":"USD", "MonetaryValue":"170.58"}, "ServiceOptionsCharges":{"CurrencyCode":"USD", "MonetaryValue":"0.00"}, "TotalCharges":{"CurrencyCode":"USD", "MonetaryValue":"170.58"}, "Weight":"12.4", "BillingWeight":{"UnitOfMeasurement":{"Code":"LBS", "Description":"Pounds"}, "Weight":"18.0"}}}]}}');
            }
            when 'CA' {
                res.setStatusCode(400);
                res.setBody('{"response":{"errors":[{"code":"111285","message":"The postal code 12345 is invalid for PA United States."}]}}');
            }
            when else {
                res.setStatusCode(500);
                res.setBody('<xml>parse error</xml>');
            }
        }

        return res;
    }
}