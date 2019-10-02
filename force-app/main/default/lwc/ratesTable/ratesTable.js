import { LightningElement, api, track } from 'lwc';
import service from '@salesforce/label/c.UI_Service';
import billedWeight from '@salesforce/label/c.UI_Billed_Weight';
import actualWeight from '@salesforce/label/c.UI_Actual_Weight';
import transportationCost from '@salesforce/label/c.UI_Transportation_Cost';
import optionCost from '@salesforce/label/c.UI_Option_Cost';
import totalCost from '@salesforce/label/c.UI_Total_Cost';

/**
 * Currency configuration.
 */
var currencyConfig = { currencyCode: "USD" };

/**
 * Column information.
 */
const columns = [
    { label: service, fieldName: "name" },
    { label: billedWeight, fieldName: "billedWeight", type: "text" },
    { label: actualWeight, fieldName: "actualWeight", type: "text" },
    { label: transportationCost, fieldName: "transportationCost", type: "currency", typeAttributes: currencyConfig },
    { label: optionCost, fieldName: "optionCost", type: "currency", typeAttributes: currencyConfig },
    { label: totalCost, fieldName: "totalCost", type: "currency", typeAttributes: currencyConfig }
];

export default class RatesTable extends LightningElement {

    /**
     * Table data.
     */
    @track
    _tableData = [];

    /**
     * Table columns.
     */
    @track
    _tableColumns = columns;

    /**
     * Row offset.
     */
    @track
    _rowOffset = 0;

    /**
     * @return the rate information.
     */
    @api
    get rateInfo() {
        return this._tableData;
    }

    /**
     * Rate information setter.
     * @param value the value to set
     */
    set rateInfo(value) {
        var tmp = [];
        var currencyCode = "";

        // Iterates over the value and builds the row data
        for (var i = 0; i < value.length; i++) {
            currencyCode = value[i].currencyCode;
            tmp.push({
                "name": value[i].name,
                "billedWeight": value[i].billedWeight + " " + value[i].weightUnits,
                "actualWeight": value[i].actualWeight + " " + value[i].weightUnits,
                "transportationCost": value[i].transportationCost,
                "optionCost": value[i].optionCost,
                "totalCost": value[i].totalCost
            });
        }

        this._tableData = tmp;
        currencyConfig.currencyCode = currencyCode;
    }
}