const $ = jQuery;
const PROXY_API_URL = grn.component.url.page("grn/proxy_api");

/**
 * @param {jQuery} $ajax_promise
 * @param {Object} callbacks
 * @param {function(Array)} resolve
 * @param {function(Object|string)} reject
 */
const ajaxPromiseExecutor = ($ajax_promise, callbacks, resolve, reject) => {
    $ajax_promise.done((data, text_status, $xhr) => {
        handleProxyPostCall($xhr, data, callbacks, resolve, reject);
    }).fail(($xhr) => {
        handleProxyPostCall($xhr, null, callbacks, resolve, reject);
    });
};

/**
 * @param {jQuery} $xhr
 * @returns {Object|null}
 */
const checkGaroonError = ($xhr) => {
    let error = null;
    if (ajaxHasCybozuError($xhr)) {
        error = JSON.parse($xhr.responseText);
    }

    return error;
};

/**
 * @param {jQuery} $xhr
 * @param {Object} result
 * @param {Object} callbacks
 * @param {function(Array)} resolve
 * @param {function(Object|string)} reject
 */
const handleProxyPostCall = ($xhr, result, callbacks = null, resolve, reject) => {
    const is_promise = callbacks === null;

    const error = checkGaroonError($xhr);

    if (error) {
        if (is_promise) {
            reject(error);
        } else if (callbacks.onFail) {
            callbacks.onFail(error);
        }

        return;
    }

    if (is_promise) {
        resolve([result.data, result.status_code, result.headers]);
    } else if (callbacks.onSuccess) {
        callbacks.onSuccess(result.data, result.status_code, result.headers);
    }
};

/**
 * @param {jQuery} $xhr
 */
const ajaxHasCybozuError = ($xhr) => {
    const headers = $xhr.getAllResponseHeaders();
    return headers && headers.match(/X-Cybozu-Error/i);
};

/**
 * @param {string} url
 * @param {string} method
 * @param {Object} headers
 * @param {Object|string} data
 * @param {function(string, number, Object)} [callback]
 * @param {function(Object|string)} [error_callback]
 * @returns {boolean}
 */
const validateProxyCall = (url, method, headers, data, callback, error_callback) => {
    const trimmed_url = $.trim(url || "");

    const valid = trimmed_url !== "" &&
        isSupportedHttpMethod(method) &&
        $.isPlainObject(headers) &&
        ($.isPlainObject(data) || typeof data === "string") &&
        (!callback || $.isFunction(callback)) &&
        (!error_callback || $.isFunction(error_callback));

    return !!valid;
};

/**
 * @param {string} method
 * @returns {boolean}
 */
const isSupportedHttpMethod = (method) => {
    return ["GET", "POST", "PUT", "DELETE"].indexOf(method) !== -1;
};

/**
 * @param {string} proxy_id
 * @param {string} url
 * @param {string} method
 * @param {Object} headers
 * @param {Object|string} data
 * @returns {Object}
 */
const createProxyCallRequestData = (proxy_id, url, method, headers, data) => {
    const proxy_data = {
        code: proxy_id,
        url: url,
        method: method,
        headers: headers,
        data: data,
        use_ajax: 1,
        csrf_ticket: grn.data.CSRF_TICKET
    };

    return proxy_data;
};

/**
 * Call an external API
 * @param {string} proxy_id
 * @param {string} url
 * @param {string} method
 * @param {Object} headers
 * @param {Object|string} data
 * @param {function(string, number, Object)} [callback]
 * @param {function(Object|string)} [error_callback]
 * @returns {garoon.Promise|null}
 */
export const send = (proxy_id, url, method, headers, data, callback, error_callback) => {
    if (!validateProxyCall(url, method, headers, data, callback, error_callback)) {
        throw new Error("Usage: garoon.base.proxy.send(proxy_id, url, method, headers, data, callback, error)");
    }

    const proxy_data = createProxyCallRequestData(proxy_id, url, method, headers, data);

    let callbacks = null;
    if ($.isFunction(callback)) {
        callbacks = {"onSuccess": callback, "onFail": error_callback};
    }

    const $ajax_promise = $.ajax({
        url: PROXY_API_URL,
        method: "post",
        data: proxy_data
    });

    const proxy_promise = new garoon.Promise(
        ajaxPromiseExecutor.bind(null, $ajax_promise, callbacks)
    );

    if ($.isFunction(callback)) {
        return null;
    }

    return proxy_promise;
};

export default {
    send,
};