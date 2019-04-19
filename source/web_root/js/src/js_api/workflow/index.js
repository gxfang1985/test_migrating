import request from "./request";

const $ = jQuery;

const request_events = [
    "workflow.request.create.show",
    "workflow.request.detail.show",
    "workflow.request.approve.show",
    "workflow.request.print.show"
];
const init = (initial_data) => {
    $.extend(true, garoon.workflow.data, initial_data);
    const events = Object.keys(initial_data);

    // in case of there's only one event will be triggered on the page
    if (events.length === 1 && request_events.indexOf(events[0]) !== -1) {
        garoon.workflow.currentEventName = events[0];
    }
};

export default {
    init,
    request
};