const $ = jQuery;
/**
 *
 * @param status
 * @param value
 * @returns {{status: *, value: string}}
 */
export const createValidateSetReturn = (status, value) => {
    return {
        status: status,
        value: typeof value !== "undefined" && value !== null ? value : ""
    };
};

/**
 *
 * @param select
 * @param value
 * @returns {boolean}
 */
export const existsSelectOption = (select, value) => {
    const $options = $(select.getElementsByTagName("option"));

    const $exists_values = $options.map((index, option) => option.value);

    return $.inArray(value.toString(), $exists_values) !== -1;
};
