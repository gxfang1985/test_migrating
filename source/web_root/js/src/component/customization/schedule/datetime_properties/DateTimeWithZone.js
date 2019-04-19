/* global GRN_TimezoneInfo */
import {parseRFC3339string, OffsetDateTime} from "../../datetime";
import {isObject, isString} from "../../../common/validator/validator";

export default class DateTimeWithZone {
    /**
     * @param {DateTimeWithZoneObject} data
     * @param {RegularEventPeriodFields|BannerEventPeriodFields|RepeatEventPeriodFields} fields
     * @param {string} property_name
     * @constructor
     */
    constructor(data, fields, property_name) {
        this._errors = [];

        /**
         * @type {RegularEventPeriodFields|BannerEventPeriodFields|RepeatEventPeriodFields}
         * @private
         */
        this._fields = fields;

        this._properyName = property_name;

        /**
         * @type {?string}
         */
        this.timeZone = null;

        /**
         * @type {?LocalDateTime}
         */
        this.dateTime = null;

        this._validateAndStoreData(data);
    }

    /**
     * @param {?string} path
     * @private
     */
    _addError(path) {
        if (path !== null) {
            this._errors.push(this._properyName + "." + path);
        } else {
            this._errors.push(this._properyName);
        }
    }

    /**
     * @returns {Array.<string>}
     */
    getErrors() {
        return this._errors;
    }

    /**
     * @param {DateTimeWithZoneObject} data
     * @private
     */
    _validateAndStoreData(data) {
        if (!isObject(data)) {
            this._addError(null);
            return;
        }

        if (data.hasOwnProperty("timeZone") && !isString(data.timeZone)) {
            this._addError("timeZone");
        }
        if (data.hasOwnProperty("dateTime") && !isString(data.dateTime)) {
            this._addError("dateTime");
        }
        if (this._errors.length !== 0) {
            return;
        }

        // Validate "timezone" property
        let timeZone = data.timeZone;
        if (data.hasOwnProperty("timeZone")) {
            if (!GRN_TimezoneInfo[timeZone]) {
                timeZone = null;
                this._addError("timeZone");
            }
        } else {
            timeZone = this._fields.getTimeZone(this._properyName);
        }
        this.timeZone = timeZone;

        if (!data.hasOwnProperty("dateTime")) {
            return;
        }

        // Validate "dateTime" property
        let dt = parseRFC3339string(data.dateTime);
        if (dt === null) {
            this._addError("dateTime");
            return;
        }

        if (timeZone === null) {
            return;
        }

        if (dt instanceof OffsetDateTime) {
            dt = dt.convertToLocalDateTime(timeZone);
        }

        if (!this._fields.isValidYear(dt.getYear())) {
            this._addError("dateTime");
            return;
        }

        if (!this._fields.isValidMinute(dt.getMinute())) {
            this._addError("dateTime");
            return;
        }

        this.dateTime = dt;
    }
}