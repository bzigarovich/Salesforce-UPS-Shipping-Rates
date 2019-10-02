/**
 * Controller class for invoking a rate request callout from Salesforce Lightning UI.
 * @author Brian Zigarovich
 */
public with sharing class RateRequestController {
    
    /**
     * Gets the shipping rates from a third party shipping service.
     * @param rrequest the shipping information (i.e. origin, destination, package details, etc.)
     * @param provider the shipping provider identifier (i.e. UPS)
     * @return the list of shipping rate options from the provider.
     */
    @AuraEnabled
    public static List<RateInfo> getRates(String requestJSON, String provider) {
        IRateRequestCallout callout = createCallout(provider);
        HttpRequest httpReq = callout.getRequest(RateRequest.parse(requestJSON));
        Http http = new Http();
        HttpResponse httpRes = http.send(httpReq);
        
        return callout.processRates(httpRes);
    }

    /**
     * Factory method for creating a provider specific rate request callout.
     * @param provider the shipping provider identifier (i.e. UPS)
     * @param the rate request callout for the specified provider.
     */
    private static IRateRequestCallout createCallout(String provider) {
        // Determine the provider
        switch on provider {
            when 'UPS' {
                return new UpsrateRequestCalloutImpl();
            }
            when else {
                throw new RateRequestException(Label.Exception_Provider_Not_Supported);
            }
        }
    }
}