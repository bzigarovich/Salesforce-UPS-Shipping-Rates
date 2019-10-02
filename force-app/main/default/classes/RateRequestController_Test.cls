/**
 * Rate request controller test class.
 * @author Brian Zigarovich
 */
@istest
private class RateRequestController_Test {

    /**
     * Gets rate reqeust object.
     * @param state the destination state
     * @return a rate request instance.
     */
    static RateRequest getReqeust(String state) {
        RateRequest rr = new RateRequest();
        
        rr.fromAddress = new RateRequest.Address();
        rr.fromAddress.attention = 'Brian Zigarovich';
        rr.fromAddress.street = '120 Curtis Court';
        rr.fromAddress.city = 'Pittsburgh';
        rr.fromAddress.stateCode = 'PA';
        rr.fromAddress.postalCode = '15237';
        rr.fromAddress.countryCode = 'US';
        
        rr.toAddress = new RateRequest.Address();
        rr.toAddress.attention = 'John Smith';
        rr.toAddress.street = '366 Robin LN SE';
        rr.toAddress.city = 'Marietta';
        rr.toAddress.stateCode = state;
        rr.toAddress.postalCode = '30067';
        rr.toAddress.countryCode = 'US';
        
        rr.shipItem = new RateRequest.PackageInfo();
        rr.shipItem.weight = 12.4;
        rr.shipItem.weightUnits = 'LBS';
        rr.shipItem.length = 10;
        rr.shipItem.width = 12;
        rr.shipItem.height = 20;
        rr.shipItem.sizeUnits = 'IN';

        return rr;
    }

    /**
     * Input error test.
     */
    @isTest static void testGetRates_InputError() {
        Test.setMock(HttpCalloutMock.class, new UpsHttpCalloutMockImpl());
        Test.startTest();

        Boolean exceptionOccurred = false;
        try {
            List<RateInfo> resp = RateRequestController.getRates(JSON.serialize(getReqeust('CA')), 'UPS');
        } catch (RateRequestException e) {
            System.assertEquals('The postal code 12345 is invalid for PA United States.', e.getMessage());
            exceptionOccurred = true;
        }
        System.assert(exceptionOccurred);

        Test.stopTest();
    }

    /**
     * Parse error test.
     */
    @isTest static void testGetRates_ParseError() {
        Test.setMock(HttpCalloutMock.class, new UpsHttpCalloutMockImpl());
        Test.startTest();

        Boolean exceptionOccurred = false;
        try {
            List<RateInfo> resp = RateRequestController.getRates(JSON.serialize(getReqeust('TX')), 'UPS');
        } catch (RateRequestException e) {
            System.assertEquals(Label.Exception_Parse_Error, e.getMessage());
            exceptionOccurred = true;
        }
        System.assert(exceptionOccurred);

        Test.stopTest();
    }

    /**
     * Valid response test.
     */
    @isTest static void testGetRates_Valid() {
        List<RateInfo> expected = new List<RateInfo>{
            new RateInfo('UPS Ground', 19.38, 0.0, 19.38, 'USD', 18.0, 12.4, 'LBS'),
            new RateInfo('UPS 3 Day Select', 45.56, 0.0, 45.56, 'USD', 18.0, 12.4, 'LBS'),
            new RateInfo('UPS 2nd Day Air', 64.02, 0.0, 64.02, 'USD', 18.0, 12.4, 'LBS'),
            new RateInfo('UPS Next Day Air Saver', 162.57, 0.0, 162.57, 'USD', 18.0, 12.4, 'LBS'),
            new RateInfo('UPS Next Day Air Early', 202.9, 0.0, 202.9, 'USD', 18.0, 12.4, 'LBS'),
            new RateInfo('UPS Next Day Air', 170.58, 0.0, 170.58, 'USD', 18.0, 12.4, 'LBS')
        };

        Test.setMock(HttpCalloutMock.class, new UpsHttpCalloutMockImpl());
        Test.startTest();
        
        List<RateInfo> resp = RateRequestController.getRates(JSON.serialize(getReqeust('GA')), 'UPS');
        System.assertEquals(6, resp.size());

        // Check the results
        for (Integer i = 0; i < resp.size(); i++) {
            System.assert(expected.get(i).equals(resp.get(i)));
        }

        Test.stopTest();
    }

    /**
     * Invalid provider test.
     */
    @isTest static void testGetRates_Invalid() {
        Test.startTest();

        Boolean exceptionOccurred = false;
        try {
            List<RateInfo> resp = RateRequestController.getRates('{}', 'FEDEX');
        } catch (RateRequestException e) {
            exceptionOccurred = true;
            System.assertEquals(Label.Exception_Provider_Not_Supported, e.getMessage());
        }
        System.assert(exceptionOccurred);

        Test.stopTest();
    }
}