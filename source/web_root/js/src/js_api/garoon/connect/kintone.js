const $ = jQuery;
const KINTONE_REQUEST_TOKEN_URL = grn.component.url.page("grn/ajax/get_kintone_request_token");

/**
 * @param {jQuery} $xhr
 * @returns boolean
 */
const ajaxHasCybozuError = ($xhr) => {
    const headers = $xhr.getAllResponseHeaders();
    return headers && headers.match(/X-Cybozu-Error/i);
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
 * @returns {garoon.Promise}
 */
export const getRequestToken = () => {
    return new garoon.Promise((resolve, reject) => {
        $.ajax({
            url: KINTONE_REQUEST_TOKEN_URL,
            method: "POST",
            data: {
                use_ajax: 1,
                csrf_ticket: grn.data.CSRF_TICKET
            }
        }).done((data, textStatus, $jqXHR) => {
            const error = checkGaroonError($jqXHR);
            if (error) {
                reject(error);
            } else if (typeof data.kintone_request_token === "undefined") {
                resolve(null);
            } else {
                resolve(data.kintone_request_token);
            }
        }).fail(($jqXHR, textStatus, errorThrown) => {
            const error = checkGaroonError($jqXHR);
            if (error) {
                return reject(error);
            }
            return reject(new Error(errorThrown));
        });
    });
};

export default {
    getRequestToken,
};