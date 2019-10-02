/**
 * Base class for building HTTP requests form Integration_Setting__mdt.
 * @author Brian Zigarovich
 */
public with sharing class IntegrationSettings {

    /**
     * Builds the HTTP request.
     * @param namedCredential the named credential for the callout
     * @param settingName the setting name for the callout
     * @return the http request with the endpoint and headers set.
     */
    public static HttpRequest buildRequest(String namedCredential, String settingName) {
        HttpRequest retval = new HttpRequest();
        
        try {
            // Gets the configuration
            Integration_Setting__mdt setting = [
                SELECT 
                    Id,
                    Method__c,
                    Resource__c,
                    (SELECT Type__c, Name__c, Value__c FROM Static_Values__r WHERE Active__c = true)
                FROM Integration_Setting__mdt
                WHERE MasterLabel = :settingName
            ];

            retval.setMethod(setting.Method__c);
            retval.setEndpoint(namedCredential + setting.Resource__c);

            // Sets the headers and query parameters
            for (Static_Value__mdt sv : setting.Static_Values__r) {
                // Determines the parameter type
                switch on sv.Type__c {
                    when 'Header' {
                        retval.setHeader(sv.Name__c, sv.Value__c);
                    }
                    when 'Query' {
                        throw new RateRequestException(Label.Exception_Query_Parameter_Not_Supported);
                    }
                }
            }
        } catch (QueryException e) {
            throw new RateRequestException(Label.Exception_No_Integration_Setting, e);
        }

        return retval;
    }

    /**
     * @return a unique identifier.
     */
    public static String getUUID() {
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        return h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
    }
}