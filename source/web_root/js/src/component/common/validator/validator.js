const dateFormatRegex = /(\d{4})-(\d{2})-(\d{2})/;

/**
 * @param {string} value
 * @returns {{year: number, month: number, day: number}|null}
 * @private
 */
const _parseDate = (value) => {
    const m = value.match(dateFormatRegex);
    if (m === null) {
        return null;
    }
    return {
        "year": parseInt(m[1], 10),
        "month": parseInt(m[2], 10),
        "day": parseInt(m[3], 10)
    };
};

/**
 * @param {string} value
 * @returns {boolean}
 */
export const isValidDate = (value) => {
    if (!isString(value)) {
        return false;
    }

    const parsedDate = _parseDate(value);
    if (parsedDate === null) {
        return false;
    }

    if (isNaN(Date.parse(value))) {
        return false;
    }

    const new_value = value + "T00:00Z";
    const date = new Date(new_value);

    return date.getUTCFullYear() === parsedDate.year
        && date.getUTCMonth() + 1 === parsedDate.month
        && date.getUTCDate() === parsedDate.day;

};

/**
 * @param {*} value
 * @return {boolean}
 */
export const isBoolean = (value) => {
    return typeof value === "boolean";
};

/**
 * @param {*} value
 * @return {boolean}
 */
export const isUndefined = (value) => {
    return typeof value === "undefined";
};

/**
 * @param {*} value
 * @returns {boolean}
 */
export const isString = (value) => {
    return typeof value === "string";
};

/**
 * @param {*} value
 * @returns {boolean}
 */
export const isObject = (value) => {
    return typeof value === "object";
};

/**
 * @param {*} function_to_check
 * @returns {boolean}
 */
export const isFunction = (function_to_check) => {
    const get_type = {};
    return function_to_check && get_type.toString.call(function_to_check) === "[object Function]";
};
