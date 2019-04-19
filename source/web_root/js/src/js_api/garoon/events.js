/* global garoon */
import * as customization_events from "../../component/customization/events";

/**
 * @param {string|array} channel
 * @param {function} callback
 */
export const on = (channel, callback) => {
    customization_events.on(channel, callback);
};

/**
 * @param {string} channel
 * @param {object} data
 */
export const trigger = (channel, data) => {
    const new_data = data;
    new_data.type = channel;
    const result = customization_events.trigger(channel, new_data);

    if (result instanceof garoon.Promise) {
        return result.then((value) => {
            return setReturnEventValue(channel, value);
        });
    }

    return setReturnEventValue(channel, result);
};

/**
 * @param {string} channel
 * @param {object} return_data
 */
const setReturnEventValue = (channel, return_data) => {
    if (return_data === null || typeof return_data !== "object") {
        return;
    }

    if (typeof return_data.type !== "string") {
        return;
    }

    const module = return_data.type.split(".")[0];
    switch (module) {
        case "workflow":
            // The specification of "workflow.request.approve.submit.success" event does not allow to set data to the Workflow's request.
            if (channel === "workflow.request.approve.submit.success") {
                return;
            }
            garoon.workflow.request.set(return_data.request);
            break;
        case "schedule":
            garoon.schedule.event.set(return_data.event);
            break;
    }
};

export default {
    on,
    trigger,
};