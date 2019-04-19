import DateTimeWithZone from "./DateTimeWithZone";

export default class BannerEventPeriod {
    /**
     * @param {{start: DateTimeWithZoneObject, end: DateTimeWithZoneObject}} data
     * @param {BannerEventPeriodFields} fields
     * @param {jQuery} $form
     * @constructor
     */
    constructor(data, fields, $form) {
        this._errors = [];

        /**
         * @type {BannerEventPeriodFields}
         * @private
         */
        this._fields = fields;

        /**
         * @type {?DateTimeWithZone}
         */
        this.start = null;

        /**
         * @type {?DateTimeWithZone}
         */
        this.end = null;
        this.$form = $form;

        this._validateAndStoreData(data);
    }

    /**
     * @returns {Array.<string>}
     */
    getErrors() {
        return this._errors;
    }

    /**
     * @param {{start: DateTimeWithZoneObject, end: DateTimeWithZoneObject}} data
     * @private
     */
    _validateAndStoreData(data) {
        const start_data = data.hasOwnProperty("start") ? data.start : {};
        const start = new DateTimeWithZone(start_data, this._fields, "start");
        if (start.getErrors().length === 0) {
            this.start = start;
        } else {
            this._errors = this._errors.concat(start.getErrors());
        }

        const end_data = data.hasOwnProperty("end") ? data.end : {};
        const end = new DateTimeWithZone(end_data, this._fields, "end");
        if (end.getErrors().length === 0) {
            this.end = end;
        } else {
            this._errors = this._errors.concat(end.getErrors());
        }
    }

    set() {
        if (this.start.dateTime !== null) {
            this._fields.setDateWithEmptyTime("start", this.start.dateTime, this.$form);
        }
        if (this.end.dateTime !== null) {
            this._fields.setDateWithEmptyTime("end", this.end.dateTime, this.$form);
        }
        this._fields.setTimeZones(this.start.timeZone, this.end.timeZone);
        this._fields.fireOnChangeEvent();
    }
}