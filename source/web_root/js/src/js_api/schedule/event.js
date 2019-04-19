/* global jQuery */
import * as appointment_field from "../../component/customization/schedule/appointment_field";
import Locale from "../../component/common/locale/Locale";
import {throwInvalidParameters} from "../../component/customization/error_handler";
import * as events from "../../component/customization/events";

const $ = jQuery;

const not_editable_events = ["schedule.event.detail.show"];

export const getHeaderSpaceElement = () => {
    const $el = $(".js_customization_schedule_header_space");
    if ($el.length === 0) {
        return null;
    }
    return $el.get(0);
};

/**
 * @param {Object} event_object
 */
export const set = (event_object) => {
    if (events.onHandle) {
        throw new Error(Locale.getMessage("grn.schedule", "customization_error_execute_request_set_on_event_handler"));
    }
    if (typeof event_object === "undefined") {
        throw new Error(Locale.getMessage("grn.schedule", "customization_error_execute_request_set_missing_param"));
    }
    if (event_object === null) {
        throw new Error(Locale.getMessage("grn.schedule", "customization_error_execute_request_set_on_null_object"));
    }
    if (garoon.schedule.currentEventName === null) {
        return;
    }
    if (not_editable_events.indexOf(garoon.schedule.currentEventName) !== -1) {
        return;
    }
    const initial_event_data = garoon.schedule.data[garoon.schedule.currentEventName];
    appointment_field.init(event_object, initial_event_data.event);

    if (appointment_field.isValidData()) {
        appointment_field.setData();
    } else {
        const error_items = appointment_field.getErrorItems();
        throwInvalidParameters(error_items);
    }
};

export const get = () => {
    if (events.onHandle) {
        throw new Error(Locale.getMessage("grn.schedule", "customization_error_execute_request_get_on_event_handler"));
    }
    if (garoon.schedule.currentEventName === null) {
        return undefined;
    }
    const initial_event_data = garoon.schedule.data[garoon.schedule.currentEventName];
    if (not_editable_events.indexOf(garoon.schedule.currentEventName) !== -1) {
        return initial_event_data.event;
    }
    return appointment_field.getData(initial_event_data.event);
};


export default {
    getHeaderSpaceElement,
    set,
    get,
};