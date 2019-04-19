import {createItem} from "./item_factory";
import {createValidateSetReturn} from "../items/utility";

/**
 *
 * @param item_code
 * @param item_info
 * @returns {*}
 */
export const getValue = (item_code, item_info) => {
    let item, value;
    const support_types = [
        "SINGLE_LINE_TEXT",
        "MULTI_LINE_TEXT",
        "NUMBER",
        "DROP_DOWN",
        "RADIO_BUTTON",
        "CHECK_BOX",
        "DATE",
        "DATETIME",
        "ROUTE_NAVI",
        "CALC"
    ];
    if (support_types.indexOf(item_info.type) !== -1) {
        item = createItem(item_info.type, item_code);
    }

    if (item) {
        value = item.getValue();
    }
    return typeof value !== "undefined" ? value : item_info.value;
};

/**
 *
 * @param new_item_info
 */
export const setValue = (new_item_info) => {
    let item;
    const support_types = [
        "SINGLE_LINE_TEXT",
        "MULTI_LINE_TEXT",
        "NUMBER",
        "DROP_DOWN",
        "RADIO_BUTTON",
        "CHECK_BOX",
        "DATE",
        "DATETIME",
        "ROUTE_NAVI"
    ];
    if (support_types.indexOf(new_item_info.type) !== -1) {
        item = createItem(new_item_info.type, new_item_info.code);
    }

    if (item) {
        item.setValue(new_item_info.value);
    }
};

/**
 *
 * @param item_code
 * @param new_item
 * @param item_info
 * @returns {*}
 */
export const validateSetValue = (item_code, new_item, item_info) => {
    if (typeof new_item.value === "undefined") {
        return createValidateSetReturn("error", "request.items[\"" + item_code + "\"].value");
    }
    let item;
    const value = typeof new_item.value === "undefined" || new_item.value === null
        ? "" : new_item.value;

    const support_types = [
        "SINGLE_LINE_TEXT",
        "MULTI_LINE_TEXT",
        "NUMBER",
        "DROP_DOWN",
        "RADIO_BUTTON",
        "CHECK_BOX",
        "DATE",
        "DATETIME",
        "ROUTE_NAVI"
    ];
    if (support_types.indexOf(item_info.type) !== -1) {
        item = createItem(item_info.type, item_code);
    }

    if (item) {
        return item.validateSetValue(value);
    }

    return createValidateSetReturn("success", value);
};
