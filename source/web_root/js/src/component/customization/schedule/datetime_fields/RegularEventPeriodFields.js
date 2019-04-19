/* global GRN_ScheduleAdd */
import {convertDateToRFC3339String, LocalDateTime} from "../../datetime";
import {triggerSetMonthAndDay} from "./DateTimeFieldsHelper";
import {getTimeZone, setTimeZones} from "./TimeZoneFieldsHelper";

export const RegularEventPeriodFields = {
    /**
     * @param {string} property_name
     * @returns {LocalDateTime}
     */
    getDateTime: (property_name) => {
        let data;
        if (property_name === "start") {
            data = GRN_ScheduleAdd.getStartDateTime();
        } else {
            data = GRN_ScheduleAdd.getEndDateTime();
        }

        const hour = data.hour !== GRN_ScheduleAdd.SELECT_VALUE_EMPTY ? data.hour : 0;
        const minute = data.minute !== GRN_ScheduleAdd.SELECT_VALUE_EMPTY ? data.minute : 0;
        return new LocalDateTime(data.year, data.month, data.day, hour, minute, 0);
    },

    /**
     * Get Event date time
     * @param {string} property_name property name (Ex: start, end, ...)
     * @returns {DateTimeWithZoneObject}
     */
    getEventDateTime: (property_name) => {
        const date = RegularEventPeriodFields.getDateTime(property_name);
        const time_zone = RegularEventPeriodFields.getTimeZone(property_name);
        const date_time = convertDateToRFC3339String(date, time_zone);
        const data = {dateTime: date_time, timeZone: time_zone};
        return data;
    },

    /**
     * check is all day or not
     * @returns {boolean}
     */
    isAllDay: () => {
        const start_date_time = GRN_ScheduleAdd.getStartDateTime();
        const end_date_time = GRN_ScheduleAdd.getEndDateTime();
        const is_all_day = start_date_time.hour === GRN_ScheduleAdd.SELECT_VALUE_EMPTY
            && start_date_time.minute === GRN_ScheduleAdd.SELECT_VALUE_EMPTY
            && end_date_time.hour === GRN_ScheduleAdd.SELECT_VALUE_EMPTY
            && end_date_time.minute === GRN_ScheduleAdd.SELECT_VALUE_EMPTY;
        return is_all_day;
    },

    /**
     *
     * Check is start only
     * @returns {boolean}
     */
    isStartOnly: () => {
        const start_date_time = GRN_ScheduleAdd.getStartDateTime();
        const end_date_time = GRN_ScheduleAdd.getEndDateTime();
        const is_all_day = start_date_time.hour !== GRN_ScheduleAdd.SELECT_VALUE_EMPTY
            && start_date_time.minute !== GRN_ScheduleAdd.SELECT_VALUE_EMPTY
            && end_date_time.hour === GRN_ScheduleAdd.SELECT_VALUE_EMPTY
            && end_date_time.minute === GRN_ScheduleAdd.SELECT_VALUE_EMPTY;
        return is_all_day;
    },

    /**
     * @param {string} property_name
     * @param {LocalDateTime} dt
     * @param {jQuery} $form
     */
    setDateTime: (property_name, dt, $form) => {
        RegularEventPeriodFields._setDateTime(
            property_name,
            dt.getYear(),
            dt.getMonth(),
            dt.getDay(),
            dt.getHour(),
            dt.getMinute(),
            $form
        );
    },

    /**
     * @param {string} property_name
     * @param {LocalDateTime} dt
     * @param {jQuery} $form
     */
    setDateWithEmptyTime: (property_name, dt, $form) => {
        RegularEventPeriodFields._setDateTime(
            property_name,
            dt.getYear(),
            dt.getMonth(),
            dt.getDay(),
            GRN_ScheduleAdd.SELECT_VALUE_EMPTY,
            GRN_ScheduleAdd.SELECT_VALUE_EMPTY,
            $form
        );
    },

    /**
     * @param {string} property_name
     * @param {number} year
     * @param {number} month
     * @param {number} day
     * @param {number} hour
     * @param {number} minute
     * @param {jQuery} $form
     * @private
     */
    _setDateTime: (property_name, year, month, day, hour, minute, $form) => {
        if (property_name === "start") {
            GRN_ScheduleAdd.setStartDateTime(year, month, day, hour, minute);
        } else {
            GRN_ScheduleAdd.setEndDateTime(year, month, day, hour, minute);
        }
        triggerSetMonthAndDay(month, day, property_name, $form);
    },

    /**
     * @param {number} year
     * @return {boolean}
     */
    isValidYear: (year) => {
        return GRN_ScheduleAdd.isValidYear(year);
    },

    /**
     * @param {number} minute
     * @return {boolean}
     */
    isValidMinute: (minute) => {
        return GRN_ScheduleAdd.isValidMinute(minute);
    },

    /**
     * @param {string} property_name
     * @returns {string}
     */
    getTimeZone: (property_name) => {
        return getTimeZone(property_name);
    },

    /**
     * @param {string} start_timezone
     * @param {string} end_timezone
     */
    setTimeZones: (start_timezone, end_timezone) => {
        setTimeZones(start_timezone, end_timezone);
    },

    /**
     */
    fireOnChangeEvent: () => {
        GRN_ScheduleAdd.onChangeDateTime();
    }
};