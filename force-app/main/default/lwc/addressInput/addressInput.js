import { LightningElement, api, track } from 'lwc';
import address from '@salesforce/label/c.UI_Address';
import attention from '@salesforce/label/c.UI_Attention';
import street from '@salesforce/label/c.UI_Street';
import city from '@salesforce/label/c.UI_City';
import state from '@salesforce/label/c.UI_State';
import postalCode from '@salesforce/label/c.UI_Postal_Code';
import country from '@salesforce/label/c.UI_Country';
import selectState from '@salesforce/label/c.UI_Select_State';
import selectCountry from '@salesforce/label/c.UI_Select_Country';

export default class AddressInput extends LightningElement {

    /**
     * Labels for UI.
     */
    uiLabels = {
        address,
        attention,
        street,
        city,
        state,
        postalCode,
        country,
        selectState,
        selectCountry
    };

    /**
     * Display label.
     */
    @api
    label = address;

    /**
     * Disabled indicator.
     */
    @api
    disabled = false;

    /**
     * Readonly indicator.
     */
    @api
    readonly = false;

    /**
     * Attention line.
     */
    @track
    _attention = "";

    /**
     * Address street.
     */
    @track
    _street = "";

    /**
     * Address city.
     */
    @track
    _city = "";

    /**
     * Address state code.
     */
    @track
    _stateCode = "";

    /**
     * Address postal code.
     */
    @track
    _postalCode = "";

    /**
     * Address country.
     */
    @track
    _countryCode = "US";

    /**
     * Gets the state options.
     */
    get states() {
        return [
            {'label':'Alabama','value':'AL'},{'label':'Alaska','value':'AK'},{'label':'Arizona','value':'AZ'},
            {'label':'Arkansas','value':'AR'},{'label':'California','value':'CA'},{'label':'Colorado','value':'CO'},
            {'label':'Connecticut','value':'CT'},{'label':'Delaware','value':'DE'},{'label':'Florida','value':'FL'},
            {'label':'Georgia','value':'GA'},{'label':'Hawaii','value':'HI'},{'label':'Idaho','value':'ID'},
            {'label':'Illinois','value':'IL'},{'label':'Indiana','value':'IN'},{'label':'Iowa','value':'IA'},
            {'label':'Kansas','value':'KS'},{'label':'Kentucky','value':'KY'},{'label':'Louisiana','value':'LA'},
            {'label':'Maine','value':'ME'},{'label':'Maryland','value':'MD'},{'label':'Massachusetts','value':'MA'},
            {'label':'Michigan','value':'MI'},{'label':'Minnesota','value':'MN'},{'label':'Mississippi','value':'MS'},
            {'label':'Missouri','value':'MO'},{'label':'Montana','value':'MT'},{'label':'Nebraska','value':'NE'},
            {'label':'Nevada','value':'NV'},{'label':'New Hampshire','value':'NH'},{'label':'New Jersey','value':'NJ'},
            {'label':'New Mexico','value':'NM'},{'label':'New York','value':'NY'},{'label':'North Carolina','value':'NC'},
            {'label':'North Dakota','value':'ND'},{'label':'Ohio','value':'OH'},{'label':'Oklahoma','value':'OK'},
            {'label':'Oregon','value':'OR'},{'label':'Pennsylvania','value':'PA'},{'label':'Rhode Island','value':'RI'},
            {'label':'South Carolina','value':'SC'},{'label':'South Dakota','value':'SD'},{'label':'Tennessee','value':'TN'},
            {'label':'Texas','value':'TX'},{'label':'Utah','value':'UT'},{'label':'Vermont','value':'VT'},
            {'label':'Virginia','value':'VA'},{'label':'Washington','value':'WA'},{'label':'West Virginia','value':'WV'},
            {'label':'Wisconsin','value':'WI'},{'label':'Wyoming','value':'WY'}
        ];
    }

    /**
     * Gets the country options.
     */
    get countries() {
        return [
            {'label':'United States','value':'US'}
        ];
    }

    /**
     * Handles input changes.
     * @param event the event object
     */
    handleChange(event) {
        // Updates the property
        switch (event.srcElement.name) {
            case "attention":
                this._attention = event.detail.value;
                break;
            case "street":
                this._street = event.detail.value;
                break;
            case "city":
                this._city = event.detail.value;
                break;
            case "stateCode":
                this._stateCode = event.detail.value;
                break;
            case "postalCode":
                this._postalCode = event.detail.value;
                break;
            case "countryCode":
                this._countryCode = event.detail.value;
                break;
            default:
                break;
        }

        event.stopPropagation();

        // Dispatches the event.
        this.dispatchEvent(new CustomEvent("addresschange", {
            "detail": {
                "attention": this._attention,
                "street": this._street,
                "city": this._city,
                "stateCode": this._stateCode,
                "postalCode": this._postalCode,
                "countryCode": this._countryCode
            }
        }));
    }

    /**
     * Validates a type of element.
     * @param {*} type the type of element to validate
     * @return true if all of elements of the specified type are valid.
     */
    validateInput(type) {
        var isValid = true;

        // Iterate over the input elements
        for (var input of this.template.querySelectorAll(type)) {
            // Checks to see if the input is valid
            if (!input.validity.valid) {
                input.showHelpMessageIfInvalid();
                isValid = false;
            }
        }

        return isValid;
    }

    /**
     * Validates the component.
     * @return true if the component is valid; otherwise false.
     */
    @api
    isValid() {
        // Verify that the component is not readonly or disabled
        if (!this.disabled && !this.readonly) {
            var inputValid = this.validateInput("lightning-input");
            var textAreaValid = this.validateInput("lightning-textarea");
            var comboboxValid = this.validateInput("lightning-combobox");

            return inputValid && textAreaValid && comboboxValid;
        }

        return false;
    }
}