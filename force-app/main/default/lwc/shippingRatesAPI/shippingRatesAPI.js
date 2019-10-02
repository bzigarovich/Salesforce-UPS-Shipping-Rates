import { LightningElement, api } from 'lwc';
import apexGetRates from '@salesforce/apex/RateRequestController.getRates';

export default class ShippingRatesAPI extends LightningElement {

    // Gets the shipping rates from a shipping provider.
    // @param request the rate request to calculate shipping rates for
    // @param provider the shipping provider
    // @return a promise, shipping rates on success; rejected on error.
    @api
    getRates(request, provider) {
        return apexGetRates({ requestJSON: JSON.stringify(request), provider: provider });
    }
}