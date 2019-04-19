import calendar from "./calendar";
import event from "./event";

const schedule_events = [
    "schedule.event.create.show",
    "schedule.event.edit.show",
    "schedule.event.detail.show"
];

/**
 * @param {Object} init_data
 */
export const init = (init_data) => {
    Object.extend(garoon.schedule.data, init_data);
    const events = Object.keys(init_data);
    if (events.length === 1 && schedule_events.indexOf(events[0]) !== -1) {
        garoon.schedule.currentEventName = events[0];
    }
};

export default {
    init,
    calendar,
    event,
};