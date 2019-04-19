const $ = jQuery;

let is_send_logging_request = false;

export const type = {
    EVENT_NAME: "eventName",
    API_NAME: "apiName"
};

export const logs = {
    eventName: [],
    apiName: []
};

// The functions belong to the namespaces or children namespace
// which are added to the following list will not write log.
export const ignoreNamespaces = ["garoon.events"];

// The functions which are added to the following list will not write log.
export const ignoreApis = [
    /^garoon\.\w+\.init$/,
    /^garoon\.Promise$/,
    /^garoon\.proxy$/
];

/**
 *
 * @param {String} namespace
 */
export const init = (namespace) => {
    registerLoggingToNamespace(namespace);
    $(window).on("beforeunload", sendRequest);
};

/**
 * @param {String} log_type
 * @param {String} name
 */
export const addLogItem = (log_type, name) => {
    if (logs[log_type].indexOf(name) === -1) {
        logs[log_type].push(name);
    }
};

/**
 *
 * @param {Function} func
 * @param {String} name
 */
export const getLoggableFunction = (func, name) => {
    return (...args) => {
        addLogItem(type.API_NAME, name);
        return func(...args);
    };
};

/**
 * Checking properties of Object, if type of property is:
 * + Object: continue to lookup its properties
 * + Function: register this property as Api
 * + Other: IGNORE
 *
 * @param {Object} namespace_object
 * @param {String} namespace_string
 */
export const registerLoggingToObject = (namespace_object, namespace_string) => {
    Object.keys(namespace_object).forEach(name => {
        const potential_function = namespace_object[name];
        const potential_function_type = Object.prototype.toString.call(potential_function);

        if (potential_function_type === "[object Object]") {
            const namespace = namespace_string + "." + name;
            if (ignoreNamespaces.indexOf(namespace) === -1) {
                registerLoggingToObject(potential_function, namespace);
            }
        } else if (potential_function_type === "[object Function]") {
            const api_name = namespace_string + "." + name;
            const is_match = ignoreApis.some((regex) => {
                return regex.test(api_name);
            });
            if (is_match === false) {
                namespace_object[name] = getLoggableFunction(potential_function, api_name); // eslint-disable-line no-param-reassign
            }
        }
    });
};

/**
 *
 * @param {String} namespace_string
 */
export const registerLoggingToNamespace = (namespace_string) => {
    if (typeof namespace_string !== "string") {
        return;
    }

    const namespace_array = namespace_string.split(".");
    let namespace_object = window[namespace_array[0]];
    for (let i = 1; i < namespace_array.length; i++) {
        namespace_object = namespace_object[namespace_array[i]];
    }

    if (typeof namespace_object === "undefined") {
        return;
    }
    registerLoggingToObject(namespace_object, namespace_string);
};

/**
 *
 * @returns {Object}
 */
export const generateParams = () => {
    const params = {};

    if (logs[type.EVENT_NAME].length > 0) {
        params[type.EVENT_NAME] = logs[type.EVENT_NAME].join("+");
    }

    if (logs[type.API_NAME].length > 0) {
        params[type.API_NAME] = logs[type.API_NAME].join("+");
    }

    return params;
};

export const sendRequest = () => {
    if (is_send_logging_request) {
        return;
    }

    // Flag to determine if sendRequest is fired
    is_send_logging_request = true;

    const params = generateParams();

    if (Object.keys(params).length <= 0) {
        return;
    }

    // Create the URL of the log
    const url = grn.component.url.page("log/jsapi", params);

    // Flag to determine if beacon has been used
    let used_beacon = false;

    // Use sendBeacon if supported
    if (navigator.sendBeacon) {
        used_beacon = navigator.sendBeacon(url);
    }

    // Fallback to async XMLHttpRequest if beacon is not supported
    if (!used_beacon) {
        $.get(url);
    }
};