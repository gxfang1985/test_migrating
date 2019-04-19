/* global jQuery */
import {isString, isValidDate} from "../../component/common/validator/validator";

const $ = jQuery;

const SUPPORTED_VIEW_TYPES = ["GROUP_DAY", "GROUP_WEEK", "DAY", "WEEK", "MONTH"];

/**
 * @param {string} view_type
 * @param {string} date
 * @returns {NULL|HTMLElement}
 */
export const getDayFirstSpaceElement = (view_type, date) => {
    if (!isString(view_type) || !isString(date)) {
        throw new Error("Usage: garoon.schedule.calendar.getDayFirstSpaceElement(viewType, date)");
    }

    if (!isValidDate(date)) {
        throw new Error("Invalid date: " + date);
    }

    if (SUPPORTED_VIEW_TYPES.indexOf(view_type) === -1) {
        throw new Error("Invalid view type: " + view_type);
    }

    const calendar_selector_prefix = ".js_customization_schedule_";

    const calendar_selector = calendar_selector_prefix + "view_type_" + view_type;
    const user_calendar_selector = calendar_selector_prefix + "user_id_" + grn.data.login.id;
    const space_element_selector = calendar_selector_prefix + "date_" + date;

    const $user_calendar = $(calendar_selector + ":first").find(user_calendar_selector);
    let $space_elements = [];
    if (view_type === "MONTH") {
        $space_elements = $user_calendar.find("tr").has(":visible").find(space_element_selector);
    } else {
        $space_elements = $user_calendar.find(space_element_selector);
    }

    if ($space_elements.length === 0) {
        return null;
    }
    return $space_elements.get(0);
};

export default {
    getDayFirstSpaceElement,
};