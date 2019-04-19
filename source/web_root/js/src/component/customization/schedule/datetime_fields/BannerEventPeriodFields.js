/* global GRN_ScheduleDate */
import {convertDateToRFC3339String, LocalDateTime} from "../../datetime";
import {triggerSetMonthAndDay} from "./DateTimeFieldsHelper";
import {getTimeZone, setTimeZones} from "./TimeZoneFieldsHelper";

export const BannerEventPeriodFields = {
    /**
     * @param {string} property_name
     * @returns {LocalDateTime}
     */
    getDateTime: (property_name) => {
        let data;
        if (property_name === "start") {
            data = GRN_ScheduleDate.getStartDate();
        } else {
            data = GRN_ScheduleDate.getEndDate();
        }

        return new LocalDateTime(data.year, data.month, data.day, 0, 0, 0);
    },

    /**
     * Get Event date time
     * @param {string} property_name property name (Ex: start, end, ...)
     * @returns {DateTimeWithZoneObject}
     */
    getEventDateTime: (property_name) => {
        const date = BannerEventPeriodFields.getDateTime(property_name);
        const time_zone = BannerEventPeriodFields.getTimeZone(property_name);
        const date_time = convertDateToRFC3339String(date, time_zone);
        const data = {dateTime: date_time, timeZone: time_zone};
        return data;
    },

    /**
     * @param {string} property_name
     * @returns {string}
     */
    getTimeZone: (property_name) => {
        return getTimeZone(property_name);
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
        return true;
    },

    /**
     * @param {string} property_name
     * @param {LocalDateTime} dt
     * @param {jQuery} $form
     */
    setDateWithEmptyTime: (property_name, dt, $form) => {
        if (property_name === "start") {
            GRN_ScheduleDate.setStartDate(dt.getYear(), dt.getMonth(), dt.getDay());
        } else {
            GRN_ScheduleDate.setEndDate(dt.getYear(), dt.getMonth(), dt.getDay());
        }
        triggerSetMonthAndDay(dt.getMonth(), dt.getDay(), property_name, $form);
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
    }
};