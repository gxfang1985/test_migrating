/* global console */
import * as validator from "../common/validator/validator";
import * as logging from "./logging";

let handlers = {};
const THENABLE_EVENTS = ["workflow.request.approve.submit.success"];
export let onHandle = false;
let _inThenableHandler = false;

/**
 * @param {string|array} events
 * @param {function} handler
 */
export const on = (events, handler) => {
    if (Array.isArray(events)) {
        events.forEach(channel => {
            garoon.events.on(channel, handler);
        });
        return;
    }

    const event = events;

    if (!handlers[event]) {
        handlers[event] = [];
    }
    handlers[event].push(handler);
};

/**
 * @param {string} event
 * @param {object} event_data
 * @returns {object|undefined}
 */
export const trigger = (event, event_data) => {
    if (_isThenableEvent(event)) {
        return _thenableTrigger(event, event_data);
    }
    return _trigger(event, event_data);
};

/**
 *
 * @param {string} channel
 * @returns {boolean}
 * @private
 */
const _isThenableEvent = (channel) => {
    return THENABLE_EVENTS.indexOf(channel) > -1;
};

/**
 * @param {string} event
 * @param {Object} event_data
 * @returns {Promise|undefined}
 * @private
 */
const _thenableTrigger = (event, event_data) => {
    if (!handlers[event]) {
        return undefined;
    }
    const handler_list = handlers[event] || [];
    const event_object = jQuery.extend(true, {"type": event}, event_data);
    onHandle = true;
    let promise = garoon.Promise.resolve(event_object);
    let last_return_value;
    try {
        logging.addLogItem(logging.type.EVENT_NAME, event);
        handler_list.forEach((handler) => {
            promise = promise.then((value) => {
                return _thenableCallHandler(handler, value).then((return_value) => {
                    last_return_value = return_value;
                    if (!validator.isUndefined(last_return_value)) {
                        return last_return_value;
                    }
                    return value;
                });
            }).catch((error) => {
                // Refer the issue "Possibly unhandled error should be thrown"
                // https://github.com/stefanpenner/es6-promise/issues/70
                console.error(error); // eslint-disable-line no-console
                return garoon.Promise.reject(error);
            });
        });
    } finally {
        onHandle = false;
    }
    return promise.then(() => {
        return last_return_value;
    });
};

/**
 * @param {Function} handler
 * @param {*} event_data
 * @returns {Promise|*}
 * @private
 */
const _thenableCallHandler = (handler, event_data) => {
    if (_inThenableHandler) {
        throw new Error("Processing event handler exists.");
    }
    _inThenableHandler = true;
    return new garoon.Promise((resolve) => {
        const return_value = handler(event_data);
        _inThenableHandler = false;
        resolve(return_value);
    });
};

/**
 * @param {string} event
 * @param {object} event_data
 * @returns {object|undefined}
 * @private
 */
const _trigger = (event, event_data) => {
    if (!handlers[event]) {
        return undefined;
    }
    onHandle = true;

    let current_event_data = event_data;
    let return_value = null;
    try {
        logging.addLogItem(logging.type.EVENT_NAME, event);
        handlers[event].forEach((handler) => {
            return_value = handler(current_event_data);
            if (return_value && validator.isFunction(return_value.then)) {
                throw new Error(event + " is not allowed to return \"Thenable\" object.");
            }
            if (!validator.isUndefined(return_value)) {
                current_event_data = return_value;
            }
        });
    } finally {
        onHandle = false;
    }

    return return_value;
};

export const off = () => {
    handlers = {};
};