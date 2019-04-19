import ItemBase from "./ItemBase";
import {createValidateSetReturn} from "./utility";

const $ = jQuery;
export default class RadioButton extends ItemBase {

    /**
     *
     * @returns {*}
     */
    getValue() {
        const $container = this.getElement();
        if ($container !== null) {
            return $container.find("input:checked").val();
        }
        return undefined;
    }

    /**
     *
     * @param value
     */
    setValue(value) {
        const $container = this.getElement();
        $container.find("input").val([value]);
    }

    /**
     *
     * @param value
     * @returns {{status, value}|*}
     */
    validateSetValue(value) {
        const $container = this.getElement();
        if ($container === null) {
            return createValidateSetReturn("read-only");
        }

        const $inputs = $container.find("input");

        if (value === "") {
            return createValidateSetReturn("success", value);
        }

        const $exists_values = $inputs.map((index, input) => input.value);
        if ($.inArray(value, $exists_values) === -1) {
            return createValidateSetReturn("error", `request.items["${this.itemCode}"].value`);
        }

        return createValidateSetReturn("success", value);
    }
}