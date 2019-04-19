/* global GRN_ScheduleSelectTimezone */
/**
 * @param {string} property_name
 * @returns {string}
 */
export const getTimeZone = (property_name) => {
    if (property_name === "start") {
        return GRN_ScheduleSelectTimezone.getStartTimeZone();
    }
    return GRN_ScheduleSelectTimezone.getEndTimeZone();
};

/**
 * @param {string} start_timezone
 * @param {string} end_timezone
 */
export const setTimeZones = (start_timezone, end_timezone) => {
    GRN_ScheduleSelectTimezone.setStartAndEndTimeZones(start_timezone, end_timezone);
};
