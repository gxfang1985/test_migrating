/* global GRN_ScheduleDate */
/* global GRN_ScheduleTimeSpan */
import {numberToString} from "../../datetime";
import {triggerSetMonthAndDay} from "./DateTimeFieldsHelper";
import {getTimeZone, setTimeZones} from "./TimeZoneFieldsHelper";

export const RepeatEventPeriodFields = {
    /**
     * @param {string} property_name
     * @param {number} year
     * @param {number} month
     * @param {number} day
     * @param {jQuery} $form
     */
    setDate: (property_name, year, month, day, $form) => {
        const is_disabled = RepeatEventPeriodFields.isPeriodElementDisabled(property_name, $form);
        if (!is_disabled) {
            if (property_name === "start") {
                GRN_ScheduleDate.setStartDate(year, month, day);
            } else {
                GRN_ScheduleDate.setEndDate(year, month, day);
            }
            triggerSetMonthAndDay(month, day, property_name, $form);
        }
    },

    /**
     * Check period date element is disabled
     * @param {string} property_name Property name (start, end)
     * @param {jQuery} $form Form object
     *
     * @return {boolean} TRUE if the element is disabled, otherwise return FALSE
     */
    isPeriodElementDisabled: (property_name, $form) => {
        let is_disabled = false;
        const $day_element = $form.find("select[name=" + property_name + "_day]");
        const $month_element = $form.find("select[name=" + property_name + "_month]");
        const $year_element = $form.find("select[name=" + property_name + "_year]");
        if ($day_element && $month_element && $year_element && $day_element.prop("disabled")
            && $month_element.prop("disabled") && $year_element.prop("disabled")) {
            is_disabled = true;
        }
        return is_disabled;
    },

    /**
     * @param {string} property_name
     * @param {number} hour
     * @param {number} minute
     */
    setTime: (property_name, hour, minute) => {
        if (property_name === "start") {
            GRN_ScheduleTimeSpan.setStartTime(hour, minute);
        } else {
            GRN_ScheduleTimeSpan.setEndHourAndMinute(hour, minute);
        }
    },

    /**
     * check is all day or not
     * @returns {boolean}
     */
    isAllDay: () => {
        const start_time = GRN_ScheduleTimeSpan.getStartTime();
        const end_time = GRN_ScheduleTimeSpan.getEndTime();
        const is_all_day = start_time.hour === GRN_ScheduleTimeSpan.SELECT_VALUE_EMPTY
            && start_time.minute === GRN_ScheduleTimeSpan.SELECT_VALUE_EMPTY
            && end_time.hour === GRN_ScheduleTimeSpan.SELECT_VALUE_EMPTY
            && end_time.minute === GRN_ScheduleTimeSpan.SELECT_VALUE_EMPTY;
        return is_all_day;
    },

    /**
     * Get period date
     * @returns {{start: string, end: string}} period
     */
    getPeriodInfo: () => {
        const start_date = GRN_ScheduleDate.getStartDate();
        const end_date = GRN_ScheduleDate.getEndDate();
        const period = {};
        period.start = RepeatEventPeriodFields.formatDate(start_date.year, start_date.month, start_date.day);
        period.end = RepeatEventPeriodFields.formatDate(end_date.year, end_date.month, end_date.day);
        return period;
    },

    /**
     * Get time info
     * @returns {{start: string, end: string}}
     */
    getTimeInfo: () => {
        const start_time = GRN_ScheduleTimeSpan.getStartTime();
        const end_time = GRN_ScheduleTimeSpan.getEndTime();
        const time = {};
        time.start = RepeatEventPeriodFields.formatTime(start_time.hour, start_time.minute);
        time.end = RepeatEventPeriodFields.formatTime(end_time.hour, end_time.minute);
        return time;
    },

    /**
     * format date with yyyy/mm/dd
     * @param {number} year
     * @param {number} month
     * @param {number} day
     * @returns {string}
     */
    formatDate: (year, month, day) => {
        const str_date = year + "-" + numberToString(month, 2) + "-" + numberToString(day, 2);
        return str_date;
    },

    /**
     * Format Time to String
     * @param {number} hour
     * @param {number} minute
     * @returns {string}
     */
    formatTime: (hour, minute) => {
        const str_hour = hour !== GRN_ScheduleTimeSpan.SELECT_VALUE_EMPTY ? numberToString(hour, 2) : "00";
        const str_minute = minute !== GRN_ScheduleTimeSpan.SELECT_VALUE_EMPTY ? numberToString(minute, 2) : "00";
        return str_hour + ":" + str_minute;
    },

    /**
     *
     * Check is start only
     * @returns {boolean}
     */
    isStartOnly: () => {
        const start_time = GRN_ScheduleTimeSpan.getStartTime();
        const end_time = GRN_ScheduleTimeSpan.getEndTime();
        const is_all_day = start_time.hour !== GRN_ScheduleTimeSpan.SELECT_VALUE_EMPTY
            && start_time.minute !== GRN_ScheduleTimeSpan.SELECT_VALUE_EMPTY
            && end_time.hour === GRN_ScheduleTimeSpan.SELECT_VALUE_EMPTY
            && end_time.minute === GRN_ScheduleTimeSpan.SELECT_VALUE_EMPTY;
        return is_all_day;
    },

    /**
     * @param {string} property_name
     */
    setEmptyTime: (property_name) => {
        RepeatEventPeriodFields.setTime(property_name, GRN_ScheduleTimeSpan.SELECT_VALUE_EMPTY, GRN_ScheduleTimeSpan.SELECT_VALUE_EMPTY);
    },

    /**
     * @param {number} year
     * @return {boolean}
     */
    isValidYear: (year) => {
        return GRN_ScheduleDate.isValidYear(year);
    },

    /**
     * @param {number} minute
     * @return {boolean}
     */
    isValidMinute: (minute) => {
        return GRN_ScheduleTimeSpan.isValidMinute(minute);
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
        GRN_ScheduleDate.onChangeDateTime();
        GRN_ScheduleTimeSpan.onChangeTime();
    }
};