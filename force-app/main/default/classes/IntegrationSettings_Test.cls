/**
 * Integration settings test class.
 * @author Brian Zigarovich
 */
@istest
private class IntegrationSettings_Test {
    
    /**
     * UPS build request test.
     */
    @isTest static void testBuildRequest_UPS() {
        Test.startTest();

        HttpRequest req = IntegrationSettings.buildRequest('callout:UpsAPI', 'RatesUPS');
        System.assertEquals('callout:UpsAPI/ship/v1/rating/Shop', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        System.assertEquals('bzigarovich', req.getHeader('Username'));
        System.assertEquals('Salesforce', req.getHeader('transactionSrc'));
        System.assertEquals('WGRyu944cqA@uhh', req.getHeader('Password'));
        System.assertEquals('application/json', req.getHeader('Content-Type'));
        System.assertEquals('7D6CAE76482417D5', req.getHeader('AccessLicenseNumber'));

        Test.stopTest();
    }

    /**
     * Invalid build request test.
     */
    @isTest static void testBuildRequest_Invalid() {
        Test.startTest();

        Boolean exceptionOccurred = false;
        try {
            HttpRequest req = IntegrationSettings.buildRequest('callout:test', 'BAD_SETTING');
        } catch (RateRequestException e) {
            exceptionOccurred = true;
            System.assertEquals(Label.Exception_No_Integration_Setting, e.getMessage());
        }
        System.assert(exceptionOccurred);

        Test.stopTest();
    }

    /**
     * Test the getUUID() method.
     */
     @isTest static void testGetUUID() {
         Test.startTest();
         System.assert(null != IntegrationSettings.getUUID());
         Test.stopTest();
     }
}