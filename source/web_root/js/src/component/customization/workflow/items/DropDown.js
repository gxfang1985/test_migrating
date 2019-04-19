import ItemBase from "./ItemBase";
import {createValidateSetReturn, existsSelectOption} from "./utility";

export default class DropDown extends ItemBase {
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

        if (!existsSelectOption($container[0], value)) {
            return createValidateSetReturn("error", `request.items["${this.itemCode}"].value`);
        }

        return createValidateSetReturn("success", value);
    }
}
