import ItemBase from "./ItemBase";
import {createValidateSetReturn} from "./utility";

export default class Checkbox extends ItemBase {
    /**
     *
     * @returns {*}
     */
    getValue() {
        const $el = this.getElement();
        if ($el !== null) {
            return $el.is(":checked");
        }
        return undefined;
    }

    /**
     *
     * @param value
     */
    setValue(value) {
        this.getElement().prop("checked", value);
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

        if (value !== true && value !== false) {
            return createValidateSetReturn("error", `request.items["${this.itemCode}"].value`);
        }

        return createValidateSetReturn("success", value);
    }
}
