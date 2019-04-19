/* global GRN_TimezoneInfo */
import * as validator from "../common/validator/validator";

export class LocalDateTime {
    /**
     * @param {number} year
     * @param {number} month
     * @param {number} day
     * @param {number} hour
     * @param {number} minute
     * @param {number} second
     * @memberOf grn.js.component.customization.datetime
     * @constructor
     */
    constructor(year, month, day, hour, minute, second) {
        this._year = year;
        this._month = month;
        this._day = day;
        this._hour = hour;
        this._minute = minute;
        this._second = second;
    }

    /**
     * @param {number} ts_in_second
     * @returns {LocalDateTime}
     */
    static fromTimestamp(ts_in_second) {
        const date = new Date(ts_in_second * 1000);
        return new LocalDateTime(date.getUTCFullYear(),
            date.getUTCMonth() + 1,
            date.getUTCDate(),
            date.getUTCHours(),
            date.getUTCMinutes(),
            date.getUTCSeconds());
    }

    /**
     * @returns {number}
     */
    getYear() {
        return this._year;
    }

    /**
     * @returns {number}
     */
    getMonth() {
        return this._month;
    }

    /**
     * @returns {number}
     */
    getDay() {
        return this._day;
    }

    /**
     * @returns {number}
     */
    getHour() {
        return this._hour;
    }

    /**
     * @returns {number}
     */
    getMinute() {
        return this._minute;
    }

    /**
     * @returns {number}
     */
    getSecond() {
        return this._second;
    }
}

export class OffsetDateTime {
    /**
     * @param {number} year
     * @param {number} month
     * @param {number} day
     * @param {number} hour
     * @param {number} minute
     * @param {number} second
     * @param {number} offset Time offset in second
     * @constructor
     */
    constructor(year, month, day, hour, minute, second, offset) {
        this._year = year;
        this._month = month;
        this._day = day;
        this._hour = hour;
        this._minute = minute;
        this._second = second;
        this._offset = offset;
    }

    /**
     * @returns {number}
     */
    getYear() {
        return this._year;
    }

    /**
     * @returns {number}
     */
    getMonth() {
        return this._month;
    }

    /**
     * @returns {number}
     */
    getDay() {
        return this._day;
    }

    /**
     * @returns {number}
     */
    getHour() {
        return this._hour;
    }

    /**
     * @returns {number}
     */
    getMinute() {
        return this._minute;
    }

    /**
     * @returns {number}
     */
    getSecond() {
        return this._second;
    }

    /**
     * @returns {number}
     */
    getTimestampInSecond() {
        return Date.UTC(this._year, this._month - 1, this._day, this._hour, this._minute, this._second) / 1000 - this._offset;
    }

    /**
     * @param {string} timezone
     * @returns {LocalDateTime}
     */
    convertToLocalDateTime(timezone) {
        const tz_offset = getTimezoneOffsetInSecond(timezone, this.getTimestampInSecond());
        if (tz_offset === null) {
            return null;
        }
        return LocalDateTime.fromTimestamp(this.getTimestampInSecond() + tz_offset);
    }
}

/**
 * @private
 * @param {string} offset_string E.g. Z, -03:30, +09:00
 * @returns {number}
 */
export const _convertOffsetStringToSeconds = (offset_string) => {
    if (offset_string === "Z") {
        return 0;
    }

    const parts = offset_string.substring(1).split(":");
    let offset_in_second = parseInt(parts[0], 10) * 3600;
    offset_in_second += parseInt(parts[1], 10) * 60;
    if (offset_string.charAt(0) === "+") {
        return offset_in_second;
    }
    return offset_in_second * -1;
};

export const _splitDatePartRegex = /^(\d{4})-(\d{2})-(\d{2})$/;

export const _splitTimePartRegex = /^([01]\d|2[0-3]):([0-5]\d):([0-5]\d)(?:\.\d+)?(Z|[+-]\d{2}:\d{2})?$/;

/**
 * Parse a rfc3339 date time string.
 *
 * Return null if the input value is invalid
 *
 * @param {string} datetime_string A date time expressed in RFC3339 format
 * @return {LocalDateTime|OffsetDateTime|null}
 */
export const parseRFC3339string = (datetime_string) => {
    if (!validator.isString(datetime_string)) {
        return null;
    }

    const date_and_time = datetime_string.split("T");
    if (date_and_time.length !== 2) {
        return null;
    }

    if (!validator.isValidDate(date_and_time[0])) {
        return null;
    }

    const date_matches = _splitDatePartRegex.exec(date_and_time[0]);
    if (date_matches === null) {
        return null;
    }
    const year = parseInt(date_matches[1], 10);
    const month = parseInt(date_matches[2], 10);
    const day = parseInt(date_matches[3], 10);

    const time_matches = _splitTimePartRegex.exec(date_and_time[1]);
    if (time_matches === null) {
        return null;
    }

    const hour = parseInt(time_matches[1], 10);
    const minute = parseInt(time_matches[2], 10);
    const second = parseInt(time_matches[3], 10);

    if (typeof time_matches[4] !== "undefined") {
        const offset_in_second = _convertOffsetStringToSeconds(time_matches[4]);
        return new OffsetDateTime(year, month, day, hour, minute, second, offset_in_second);
    }
    return new LocalDateTime(year, month, day, hour, minute, second);
};

/**
 * Get the time zone offset in the specified timestamp.
 *
 * @param {string} timezone_string
 * @param {number} ts_in_second
 * @return {?number}
 */
export const getTimezoneOffsetInSecond = (timezone_string, ts_in_second) => {
    const transitions = GRN_TimezoneInfo[timezone_string];
    if (!transitions) {
        return null;
    }

    if (ts_in_second < transitions[0].ts) {
        return null;
    }

    let offset = transitions[0].offset;

    for (let i = 0; i < transitions.length; i++) {
        if (transitions[i].ts > ts_in_second) {
            break;
        }
        offset = transitions[i].offset;
    }

    return parseInt(offset, 10);
};

/**
 * @param {string} date_string
 * @returns {{year: number, month: number, day: number}|null}
 */
export const parseRFC3339DatePartString = (date_string) => {
    const matches = _splitDatePartRegex.exec(date_string);
    if (matches === null) {
        return null;
    }
    if (!validator.isValidDate(date_string)) {
        return null;
    }
    const year = parseInt(matches[1], 10);
    const month = parseInt(matches[2], 10);
    const day = parseInt(matches[3], 10);

    return {
        year: year,
        month: month,
        day: day
    };
};

/**
 * @param {string} time_string
 * @returns {{hour: number, minute: number, second: number}|null}
 */
export const parseRFC3339TimePartString = (time_string) => {
    const matches = _splitTimePartRegex.exec(time_string);

    if (matches === null) {
        return null;
    }

    const hour = parseInt(matches[1], 10);
    const minute = parseInt(matches[2], 10);
    const second = parseInt(matches[3], 10);

    return {
        hour: hour,
        minute: minute,
        second: second
    };
};

/**
 * Convert date to Iso 8601
 * @param {LocalDateTime} date_obj Date
 * @param {string} time_zone time zone
 * @returns {null|string} date_time formatted yyyy-mm-ddThh:mm:ss(+/-)UTC:00 (Ex: 2017-08-11T03:15:00+09:00)
 */
export const convertDateToRFC3339String = (date_obj, time_zone) => {
    if (!GRN_TimezoneInfo[time_zone]) {
        return null;
    }
    const timezone_info = GRN_TimezoneInfo[time_zone][0];
    const utc_offset = timezone_info.offset / 3600;
    let utc_offset_prefix = "+";
    let string_utc_offset = utc_offset + "";
    if (utc_offset < 0) {
        utc_offset_prefix = "-";
        string_utc_offset = -utc_offset + "";
    }
    if (string_utc_offset.length < 2) {
        string_utc_offset = "0" + string_utc_offset;
    }
    const date = date_obj.getYear() + "-" + numberToString(date_obj.getMonth(), 2) + "-" + numberToString(date_obj.getDay(), 2);
    const time = numberToString(date_obj.getHour(), 2)
        + ":" + numberToString(date_obj.getMinute(), 2)
        + ":" + numberToString(date_obj.getSecond(), 2);
    const date_time = date + "T" + time + utc_offset_prefix + string_utc_offset + ":00";
    return date_time;
};

/**
 * Convert number to string with length
 * @param {number} number
 * @param {number} length string length
 * @returns {string}
 */
export const numberToString = (number, length) => {
    return ("0" + number).slice(-length);
};