const $ = jQuery;
import {createValidateSetReturn} from "./utility";

export default class ItemBase {
    /**
     *
     * @param item_code
     * @constructor
     */
    constructor(item_code) {
        this.itemCode = item_code;
        this.containerClassName = "js_customization_input_item_" + item_code;
    }

    /**
     *
     * @returns {*}
     */
    getElement() {
        const els = document.getElementsByClassName(this.containerClassName);
        if (els.length === 0) {
            return null;
        }
        return $(els[0]);
    }

    /**
     *
     * @returns {*}
     */
    getValue() {
        const $el = this.getElement();
        if ($el !== null) {
            return $el.val();
        }
        return undefined;
    }

    /**
     *
     * @param value
     * @returns {{status, value}|*}
     */
    validateSetValue(value) {
        const $el = this.getElement();
        if ($el === null) {
            return createValidateSetReturn("read-only");
        }

        return createValidateSetReturn("success", value);
    }

    /**
     *
     * @param value
     */
    setValue(value) {
        this.getElement().val(value);
    }
}
