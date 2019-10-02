import { LightningElement, api, track } from 'lwc';
import weight from '@salesforce/label/c.UI_Weight';
import units from '@salesforce/label/c.UI_Units';
import selectUnits from '@salesforce/label/c.UI_Select_Units';

export default class WeightInput extends LightningElement {

    /**
     * UI Units.
     */
    uiLabels = {
        weight,
        units,
        selectUnits
    };

    /**
     * Display label.
     */
    @api
    label = weight;

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
     * Package weight.
     */
    @track
    _weight;

    /**
     * Package units.
     */
    @track
    _units = "LBS";

    /**
     * Gets the unit options.
     */
    get units() {
        return [
            {'label':'Pounds','value':'LBS'},
            {'label':'Kilograms','value':'KGS'}
        ];
    }

    /**
     * Handles input changes.
     * @param event the event object
     */
    handleChange(event) {
        // Updates the property
        switch (event.srcElement.name) {
            case "weight":
                this._weight = event.detail.value;
                break;
            case "units":
                this._units = event.detail.value;
                break;
            default:
                break;
        }

        event.stopPropagation();

        // Dispatches the event.
        this.dispatchEvent(new CustomEvent("weightchange", {
            "detail": {
                "weight": this._weight,
                "units": this._units
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
            return this.validateInput("lightning-input") && 
                this.validateInput("lightning-combobox");
        }

        return false;
    }
}