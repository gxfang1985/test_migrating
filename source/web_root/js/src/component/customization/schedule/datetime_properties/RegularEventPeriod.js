import DateTimeWithZone from "./DateTimeWithZone";

export default class RegularEventPeriod {
    /**
     * @param {{start: DateTimeWithZoneObject, end: DateTimeWithZoneObject}} data
     * @param {RegularEventPeriodFields} fields
     * @param {TimeFlags} time_flags
     * @param {jQuery} $form
     * @constructor
     */
    constructor(data, fields, time_flags, $form) {
        this._errors = [];

        /**
         * @type {RegularEventPeriodFields}
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

        this._timeFlags = time_flags;
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
     */
    _validateAndStoreData(data) {
        const start_data = data.hasOwnProperty("start") ? data.start : {};
        const start = new DateTimeWithZone(start_data, this._fields, "start");
        if (start.getErrors().length === 0) {
            this.start = start;
        } else {
            this._errors = this._errors.concat(start.getErrors());
        }

        if (!this._timeFlags.isStartOnly) {
            const end_data = data.hasOwnProperty("end") ? data.end : {};
            const end = new DateTimeWithZone(end_data, this._fields, "end");
            if (end.getErrors().length === 0) {
                this.end = end;
            } else {
                this._errors = this._errors.concat(end.getErrors());
            }
        }
    }

    set() {
        const is_start_only = this._timeFlags.isStartOnly;
        const is_all_day = this._timeFlags.isAllDay;

        if (!is_start_only && !is_all_day) {
            if (this.start.dateTime !== null) {
                this._fields.setDateTime("start", this.start.dateTime, this.$form);
            }
            if (this.end.dateTime !== null) {
                this._fields.setDateTime("end", this.end.dateTime, this.$form);
            }
            this._fields.setTimeZones(this.start.timeZone, this.end.timeZone);
        } else if (is_start_only) {
            if (this.start.dateTime !== null) {
                this._fields.setDateTime("start", this.start.dateTime, this.$form);
                this._fields.setDateWithEmptyTime("end", this.start.dateTime, this.$form);
            }
            this._fields.setTimeZones(this.start.timeZone, this.start.timeZone);
        } else if (is_all_day) {
            if (this.start.dateTime !== null) {
                this._fields.setDateWithEmptyTime("start", this.start.dateTime, this.$form);
            }
            if (this.end.dateTime !== null) {
                this._fields.setDateWithEmptyTime("end", this.end.dateTime, this.$form);
            }
            this._fields.setTimeZones(this.start.timeZone, this.end.timeZone);
        }

        this._fields.fireOnChangeEvent();
    }
}