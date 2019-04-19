import {parseRFC3339DatePartString} from "../../datetime";

export default class RepeatEventPeriod {
    /**
     * @param {PeriodObject} period
     * @param {RepeatEventPeriodFields} fields
     * @param {jQuery} $form
     * @constructor
     */
    constructor(period, fields, $form) {
        this._errors = [];

        /**
         * @type {RepeatEventPeriodFields}
         * @private
         */
        this._fields = fields;

        /**
         * @type {{year: number, month: number, day:/setTime number}|null}
         */
        this.start = null;

        /**
         * @type {{year: number, month: number, day:/setTime number}|null}
         */
        this.end = null;
        this.$form = $form;

        this._validateAndStoreData(period);
    }

    /**
     * @returns {Array.<string>}
     */
    getErrors() {
        return this._errors;
    }

    /**
     * @param {PeriodObject} period
     */
    _validateAndStoreData(period) {
        if (period.hasOwnProperty("start")) {
            this.start = this._validate(period, "start");
        }
        if (period.hasOwnProperty("end")) {
            this.end = this._validate(period, "end");
        }
    }

    /**
     * validate repeat event period
     * @param {PeriodObject} period
     * @param {string} property_name
     * @returns {{year: number, month: number, day: number}|null}
     * @private
     */
    _validate(period, property_name) {
        const parsed_data = parseRFC3339DatePartString(period[property_name]);
        if (parsed_data !== null) {
            if (this._fields.isValidYear(parsed_data.year)) {
                return parsed_data;
            }
        }
        this._errors.push("repeatInfo.period." + property_name);
        return null;
    }

    /**
     * Set data to period field
     */
    set() {
        if (this.start) {
            this._fields.setDate("start", this.start.year, this.start.month, this.start.day, this.$form);
        }
        if (this.end) {
            this._fields.setDate("end", this.end.year, this.end.month, this.end.day, this.$form);
        }
        this._fields.fireOnChangeEvent();
    }
}