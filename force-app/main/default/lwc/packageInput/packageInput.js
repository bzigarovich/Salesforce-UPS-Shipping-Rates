import { LightningElement, api } from 'lwc';

export default class PackageInput extends LightningElement {

    /**
     * Display label.
     */
    @api
    label = "Package Information";

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
    _length;

    /**
     * Package width.
     */
    _width;

    /**
     * Package height.
     */
    _height;

    /**
     * Size units.
     */
    _sizeUnits;

    /**
     * Package weight.
     */
    _weight;

    /**
     * Weight units.
     */
    _weightUnits;

    /**
     * Handles dimension change event.
     * @param {*} evt the event data
     */
    handleDimensionChange(evt) {
        this._length = evt.detail.length;
        this._width = evt.detail.width;
        this._height = evt.detail.height;
        this._sizeUnits = evt.detail.units;
        this.firePackageEvent();
    }

    /**
     * Handles weight change event.
     * @param {*} evt the event data
     */
    handleWeightChange(evt) {
        this._weight = evt.detail.weight;
        this._weightUnits = evt.detail.units;
        this.firePackageEvent();
    }

    /**
     * Fires package event.
     */
    firePackageEvent() {
        // Dispatches the event.
        this.dispatchEvent(new CustomEvent("packagechange", {
            "detail": {
                "weight": this._weight,
                "weightUnits": this._weightUnits,
                "length": this._length,
                "width": this._width,
                "height": this._height,
                "sizeUnits": this._sizeUnits
            }
        }));
    }

    /**
     * Validates the component.
     * @return true if the component is valid; otherwise false.
     */
    @api
    isValid() {
        var dimensionsValid = this.template.querySelectorAll("c-dimension-input")[0].isValid();
        var weightValid = this.template.querySelectorAll("c-weight-input")[0].isValid();

        return dimensionsValid && weightValid;
    }
}