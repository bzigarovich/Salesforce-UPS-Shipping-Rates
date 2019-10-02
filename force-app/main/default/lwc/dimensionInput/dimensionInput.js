import { LightningElement, api, track } from 'lwc';
import length from '@salesforce/label/c.UI_Length';
import width from '@salesforce/label/c.UI_Width';
import height from '@salesforce/label/c.UI_Height';
import units from '@salesforce/label/c.UI_Units';
import selectUnits from '@salesforce/label/c.UI_Select_Units';

export default class DimensionInput extends LightningElement {

    /**
     * UI Labels.
     */
    uiLabels = {
        length,
        width,
        height,
        units,
        selectUnits
    };

    /**
     * Display label.
     */
    @api
    label = "Dimensions";

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
     * Package length.
     */
    @track
    _length;

    /**
     * Package width.
     */
    @track
    _width;

    /**
     * Package height.
     */
    @track
    _height;

    /**
     * Package units.
     */
    @track
    _units = "IN";

    /**
     * Gets the unit options.
     */
    get units() {
        return [
            {'label':'Inches','value':'IN'},
            {'label':'Centimeters','value':'CM'}
        ];
    }

    /**
     * Handles input changes.
     * @param event the event object
     */
    handleChange(event) {
        // Updates the property
        switch (event.srcElement.name) {
            case "length":
                this._length = event.detail.value;
                break;
            case "width":
                this._width = event.detail.value;
                break;
            case "height":
                this._height = event.detail.value;
                break;
            case "units":
                this._units = event.detail.value;
                break;
            default:
                break;
        }

        event.stopPropagation();

        // Dispatches the event.
        this.dispatchEvent(new CustomEvent("dimensionchange", {
            "detail": {
                "length": this._length,
                "width": this._width,
                "height": this._height,
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