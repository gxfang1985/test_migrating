import {parseRFC3339TimePartString} from "../../datetime";

export default class RepeatEventTime {
    /**
     * @param {TimeObject} time
     * @param {RepeatEventPeriodFields} fields
     * @param {RepeatTimeFlags} time_flags
     * @constructor
     */
    constructor(time, fields, time_flags) {
        this._errors = [];

        /**
         * @type {RepeatEventPeriodFields}
         * @private
         */
        this._fields = fields;

        /**
         * @type {{hour: number, minute: number, second: number}|null}
         */
        this.start = null;

        /**
         * @type {{hour: number, minute: number, second: number}|null}
         */
        this.end = null;
        this._timeFlags = time_flags;

        this._validateAndStoreData(time);
    }

    /**
     * @returns {Array.<string>}
     */
    getErrors() {
        return this._errors;
    }

    /**
     * @param {TimeObject} time
     * @private
     */
    _validateAndStoreData(time) {
        if (!this._timeFlags.isAllDay) {
            if (time.hasOwnProperty("start")) {
                this.start = this._validate(time, "start");
            }
            if (!this._timeFlags.isStartOnly && time.hasOwnProperty("end")) {
                this.end = this._validate(time, "end");
            }
        }
    }

    /**
     * validate repeat event time
     * @param {TimeObject} time
     * @param {string} property_name
     * @returns {{hour: number, minute: number, second: number}|null}
     * @private
     */
    _validate(time, property_name) {
        const parsed_data = parseRFC3339TimePartString(time[property_name] + ":00");
        if (parsed_data !== null) {
            if (this._fields.isValidMinute(parsed_data.minute)) {
                return parsed_data;
            }
        }
        this._errors.push("repeatInfo.time." + property_name);
        return null;
    }

    /**
     * Set data to time field
     */
    set() {
        const is_start_only = this._timeFlags.isStartOnly;
        const is_all_day = this._timeFlags.isAllDay;
        if (!is_start_only && !is_all_day) {
            if (this.start) {
                this._fields.setTime("start", this.start.hour, this.start.minute);
            }
            if (this.end) {
                this._fields.setTime("end", this.end.hour, this.end.minute);
            }
        } else if (is_start_only) {
            if (this.start) {
                this._fields.setTime("start", this.start.hour, this.start.minute);
            }
            this._fields.setEmptyTime("end");
        } else if (is_all_day) {
            this._fields.setEmptyTime("start");
            this._fields.setEmptyTime("end");
        }
        this._fields.fireOnChangeEvent();
    }
}